Level = Class{}

function Level:init(player)
    self.player = player
    -- variables that keep track of the score and level
    self.player.score = 0
    self.lvl = 1

    self.entities = {}
    self.lastSpawned = nil
    self.deadCount = 0
end

function Level:generateEntities()
    local types = {'eye', 'goblin', 'mushroom', 'skeleton', 'fire-wizard', 'violet-wizard'}

    if #self.entities < 2 * self.lvl then
        ::retry::
        -- entities gets a reference to the player
        local entity = Entity(ENTITY_DEFS[types[math.random(#types)]], self.player)

        if entity.type == self.lastSpawned then
            goto retry
        else
            self.lastSpawned = entity.type
        end

        table.insert(self.entities, entity)

        entity.stateMachine = StateMachine {
            ['attack'] = function () return EntityAttackState(entity) end,
            ['ranged'] = function () return EntityRangedState(entity) end,
            ['idle'] = function () return EntityIdleState(entity) end,
            ['death'] = function () return EntityDeathState(entity) end,
            ['run'] = function () return EntityRunState(entity) end,
            ['take hit'] = function () return EntityTakeHitState(entity) end
        }
        entity.stateMachine:change('idle')
    end
end

function Level:generateEntity()
    -- a function to spawn a single hard-code entity
    -- used during development to test single entity behaviors and balance the game
    local type = 'skeleton'

    local entity = Entity(ENTITY_DEFS[type], self.player)
    table.insert(self.entities, entity)

    entity.stateMachine = StateMachine {
        ['attack'] = function () return EntityAttackState(entity) end,
        ['ranged'] = function () return EntityRangedState(entity) end,
        ['idle'] = function () return EntityIdleState(entity) end,
        ['death'] = function () return EntityDeathState(entity) end,
        ['run'] = function () return EntityRunState(entity) end,
        ['take hit'] = function () return EntityTakeHitState(entity) end
    }
    entity.stateMachine:change('idle')
end

function Level:updateLevel()
    -- if the amount of dead enemies is equal to current level times 2
    if self.deadCount == self.lvl * 2 then
        -- pass to the successive level (up to level 7)
        self.lvl = math.min(self.lvl + 1, 7)
        -- reset dead counter
        self.deadCount = 0
    end
end

function Level:update(dt)
    -- updates all entities
    for i, entity in ipairs(self.entities) do
        if not entity.dead then
            entity:update(dt)
        else
            -- if an entity dies removes it from the table and updates deadCount and score
            table.remove(self.entities, i)
            self.deadCount = self.deadCount + 1
            self.player.score = self.player.score + 1
        end
    end
    -- checks if the level needs to be increased
    self:updateLevel()
    -- generate more entities according to the current level
    self:generateEntities()
end

function Level:render()
    -- render all entities in the level
    for i, entity in ipairs(self.entities) do
        entity:render()
    end
end
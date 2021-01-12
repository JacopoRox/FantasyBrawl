Level = Class{}

function Level:init(player)
    self.player = player
    self.player.score = 0
    self.player.lvl = 1
    self.entities = {}
    self.lastSpawned = nil
    --self:generateEntity()
    self.lvl = 1
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
    local types = {'skeleton'}

    for i, v in ipairs(types) do
        local entity = Entity(ENTITY_DEFS[v], self.player)

        table.insert(self.entities, entity)

        -- each enemy entity gets a reference to the player
        entity.player = self.player

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

function Level:updateLevel()
    if self.deadCount == self.lvl * 2 then
        self.lvl = math.min(self.lvl + 1, 7)
        self.player.lvl = self.lvl
        self.deadCount = 0
    end
end

function Level:update(dt)
    for i, entity in ipairs(self.entities) do
        if not entity.dead then
            entity:update(dt)
        else
            table.remove(self.entities, i)
            self.deadCount = self.deadCount + 1
            self.player.score = self.player.score + 1
        end
    end
    self:updateLevel()
    self:generateEntities()
end

function Level:render()
    for i, entity in ipairs(self.entities) do
        entity:render()
    end
end
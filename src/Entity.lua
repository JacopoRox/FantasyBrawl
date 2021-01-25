--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Entity = Class{}

function Entity:init(def, player)
    -- the type of our reference
    self.type = def.type
    -- a reference to the player if the entity is not the player itself
    self.player = player or nil

    -- dimensions for drawing and hitbox
    -- x gets randomized outside the screen if not defined
    self.x = def.x or self:randomSpawn()
    self.y = def.y or FLOOR
    self.width = def.width * def.scale
    self.height = def.height * def.scale

    -- drawing offsets and scale for adjustments of the various sprites and hurtbox
    self.scaleX = def.scale or 1
    self.scaleY = def.scale or 1
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    self.box = {
        offsetX = def.hurtbox.offsetX * def.scale,
        offsetY = def.hurtbox.offsetY * def.scale
    }

    -- stats
    self.health = def.health
    self.strenght = def.strenght
    self.speed = def.speed
    self.atkspeed = def.atkspeed or 0.1
    self.atkrange = def.atkrange * def.scale
    self.atkframe = def.atkframe
    self.jump = def.jump or 0
    self.restTime =  def.restTime or 0
    self.ranged = def.ranged or false
    if self.ranged then
        self.projectiles = {}
    end

    -- flags
    self.atkmove = def.atkmove or false
    self.dead = false
    self.invulnerable = false
    self.aggressive = def.aggressive or false
    self.invulnerableTimer = 0
    self.flashTimer = 0

    -- initiate animations
    self.animations = self:generateAnimations(self.type)
    -- initiate hurtbox
    self.hurtbox = self:calculateHurtbox()
    -- initiate healthbar
    self.healthbar = Healthbar(self)
end

function Entity:randomSpawn()
    -- randomizes spawn x value of an entity outside the screen
    if math.random(2) == 1 then
        return self.player.x - WINDOW_WIDTH/2 - 200
    else
        return self.player.x + WINDOW_WIDTH/2 + 200
    end
end

function Entity:changeAnimation(name)
    -- changes the animation and reset the new one
    self.currentAnimation = self.animations[name]
    self.currentAnimation:restart()
end

function Entity:damage(dmg)
    -- entity health gets decreased accoding to dmg
    if not self.invulnerable and not self.dead then
        self.health = math.max(0, self.health - dmg)
        self.stateMachine:change('take hit')
    end
end

function Entity:updateProjectiles(dt)
    -- updates all the projectile owned by the entity
    -- removing them from the table if they hit self.player
    for i, projectile in ipairs(self.projectiles) do
        projectile:update(dt)
        if self.player.hurtbox:collides(projectile.hitbox) then
            self.player:damage(projectile.strenght)
            table.remove(self.projectiles, i)
        elseif projectile.explode and projectile.animation.timesPlayed == 1 then
            table.remove(self.projectiles, i)
        end
    end
end

function Entity:calculateHurtbox()
    -- generates and hurtbox
    local hurtboxX, hurtboxY = self.x - self.box.offsetX, self.y - self.box.offsetY

    return Box(hurtboxX, hurtboxY, self.width, self.height)
end

function Entity:calculateHitbox()
    -- generate and hitbox
    local hitboxX, hitboxY, hitboxWidth, hitboxHeight

    if self.scaleX > 0 then
        hitboxX = self.hurtbox.x + self.hurtbox.width
        hitboxY = self.hurtbox.y
        hitboxWidth = self.atkrange
        hitboxHeight = self.hurtbox.height
    else
        hitboxX = self.hurtbox.x - self.atkrange
        hitboxY = self.hurtbox.y
        hitboxWidth = self.atkrange
        hitboxHeight = self.hurtbox.height
    end

    return Box(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
end

function Entity:generateAnimations(type)
    -- generate an animation for each texture
    local animationsReturned = {}

    for k, v in pairs(gFrames[type]) do
        animationsReturned[k] = Animation {
            frames = v,
            texture = gTextures[type][k],
        }
    end

    return animationsReturned
end

function Entity:updatePosition(dt)
    -- updates entity position
    self.x = self.x + self.dx * dt
    if self.dy then
        self.dy = self.dy + self.gravity * dt
        self.y = self.y + self.dy * dt
    end
    -- updates the hurtbox according to entity x and y
    local hurtboxX, hurtboxY = self.x - self.box.offsetX, self.y - self.box.offsetY
    self.hurtbox:update(hurtboxX, hurtboxY)
    -- updates the healthbar according to entity x and y
    self.healthbar:update()
end

function Entity:getDirection()
    -- returns the direction that the entity is facing
    if self.scaleX > 0 then
        return 'right'
    else
        return 'left'
    end
end

function Entity:face(entity)
    -- sets the x scale to face the entity
    if (self.x > entity.x and self.scaleX > 0) or (self.x < entity.x and self.scaleX < 0) then
        self.scaleX = -self.scaleX
    end
end

function Entity:inRange(entity)
    -- calculates wheter the entity is in range for attacking
    local hurtbox = self.hurtbox
    local target = entity.hurtbox

    return not (hurtbox.x + hurtbox.width + self.atkrange - 10 < target.x or hurtbox.x - self.atkrange + 10 > target.x + target.width)
end

function Entity:goInvulnerable(duration)
    -- sets invulnerable for a duration
    self.invulnerable = true
    -- if a duration is not specified goes invulnerable forever
    self.invulnerableDuration = duration or math.huge
end

function Entity:update(dt)
    -- reset invulnerable to false if enough time has passed
    if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end
    -- updates projectiles
    if self.ranged then
        self:updateProjectiles(dt)
    end
    -- updates the stateMachine in whatever state the entity is in
    self.stateMachine:update(dt)
end

function Entity:render()
    -- draw sprite slightly transparent if invulnerable every 0.05 seconds
    if self.invulnerable and self.flashTimer > 0.05 then
        self.flashTimer = 0
        love.graphics.setColor(1, 1, 1, 0.4)
    end
    -- renders projectiles
    if self.ranged then
        for i, v in ipairs(self.projectiles) do
            v:render()
        end
    end
    -- renders the entity at it current state
    self.stateMachine:render()
    -- renders the healthbar if alive
    if not self.dead then
        self.healthbar:render()
    end
    -- draws hurtbox of the entity if needed during development
    -- self.hurtbox:render()
end
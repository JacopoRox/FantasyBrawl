--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

EntityDeathState = Class{__includes = BaseState}

function EntityDeathState:init(entity)
    self.entity = entity
    -- entity can not take damage during the death animation
    self.entity.invulnerable = true
    self.entity:changeAnimation('death')
    self.entity.currentAnimation.interval = 0.15
    -- dy and gravity are initialized
    self.entity.dy = 0
    self.entity.gravity = GRAVITY
end

function EntityDeathState:update(dt)
    local entity = self.entity
    local anim = self.entity.currentAnimation

    anim:update(dt)
    -- falls to the floor but not further
    if entity.y > FLOOR then
        entity.dy = 0
        entity.y = FLOOR
        entity.gravity = 0
    end
    entity:updatePosition(dt)
    -- when animation is over entity is flagged as dead
    if anim.timesPlayed == 1 then
        anim.currentFrame = #anim.frames
        anim.timesPlayed = 0
        entity.dead = true
    end
end

function EntityDeathState:render()
    local anim = self.entity.currentAnimation
    -- renders the current animation
    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY,
        self.entity.scaleX, self.entity.scaleY, true)
end
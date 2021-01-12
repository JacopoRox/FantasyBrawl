EntityDeathState = Class{__includes = BaseState}

function EntityDeathState:init(entity)
    self.entity = entity
    self.entity.invulnerable = true
    self.entity:changeAnimation('death')
    self.entity.currentAnimation.interval = 0.15
    self.entity.dy = 0
    self.entity.gravity = GRAVITY
end

function EntityDeathState:update(dt)
    local entity = self.entity
    local anim = self.entity.currentAnimation

    anim:update(dt)

    if entity.y > FLOOR then
        entity.dy = 0
        entity.y = FLOOR
        entity.gravity = 0
    end
    entity:updatePosition(dt)

    if anim.timesPlayed == 1 then
        anim.currentFrame = #anim.frames
        anim.timesPlayed = 0
        entity.dead = true
    end
end

function EntityDeathState:render()
    local anim = self.entity.currentAnimation

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY,
        self.entity.scaleX, self.entity.scaleY, true)

    self.entity.healthbar:render()
end
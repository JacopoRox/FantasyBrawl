EntityRangedState = Class{__includes = BaseState}

function EntityRangedState:init(entity)
    self.entity = entity
    self.entity:face(self.entity.player)
    self.entity:changeAnimation('ranged')
    self.entity.currentAnimation.interval = self.entity.atkspeed
end

function EntityRangedState:update(dt)
    local entity = self.entity
    local player = self.entity.player
    local anim = self.entity.currentAnimation
    anim:update(dt)

    if anim.timesPlayed == 1 then
        table.insert(entity.projectiles, Projectile(entity))
        anim.timesPlayed = 0
        entity.stateMachine:change('idle')
    end
end

function EntityRangedState:render()
    local anim = self.entity.currentAnimation

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
    self.entity.healthbar:render()
end
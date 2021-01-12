EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('idle')

    -- used for AI waiting
    self.waitDuration = self.entity.restTime
    self.waitTimer = 0
end

function EntityIdleState:update(dt)
    local entity = self.entity
    local player = self.entity.player
    local anim = self.entity.currentAnimation
    anim:update(dt)

    self.waitTimer = self.waitTimer + dt
    -- if enough time has passed turns and moves
    if self.waitTimer > self.waitDuration then
        entity.stateMachine:change('run')
        -- attacks if in range
        if entity:inRange(player) then
            entity.stateMachine:change('attack')
        elseif math.random(5) == 5 and entity.ranged then
            entity.stateMachine:change('ranged')
        end
    end
end

function EntityIdleState:render()
    local anim = self.entity.currentAnimation

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)

    self.entity.healthbar:render()
end
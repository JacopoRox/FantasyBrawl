--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

EntityIdleState = Class{__includes = BaseState}

function EntityIdleState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('idle')

    -- used for cooldown on actions
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
        -- attacks if in range
        if entity:inRange(player) then
            entity.stateMachine:change('attack')
        elseif math.random(5) == 5 and entity.ranged then
            entity.stateMachine:change('ranged')
        else
            entity.stateMachine:change('run')
        end
    end
end

function EntityIdleState:render()
    local anim = self.entity.currentAnimation

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
end
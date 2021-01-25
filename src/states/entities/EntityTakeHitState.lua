--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

EntityTakeHitState = Class{__includes = BaseState}

function EntityTakeHitState:init(entity)
    self.entity = entity
    -- goes invulnerable indefinitely
    self.entity:goInvulnerable()
    self.entity:changeAnimation('take hit')
    -- entity stops moving
    self.entity.dx = 0
end

function EntityTakeHitState:update(dt)
    local entity = self.entity
    local anim = self.entity.currentAnimation
    anim:update(dt)
    entity:updatePosition(dt)

    -- at the end of the animation states is set to idle or death depending on remaining health
    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        if entity.health == 0 then
            entity.stateMachine:change('death')
        else
            entity.stateMachine:change('idle')
            entity:goInvulnerable(entity.restTime)
        end
    end
end

function EntityTakeHitState:render()
    local anim = self.entity.currentAnimation

    if anim.currentFrame == 2 then
        --set shader to create a white silhoutte on the second frame
        love.graphics.setShader(gShaders['white'])
    end
    -- renders current animation
    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
    --reset a default shader
    love.graphics.setShader()
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

EntityRunState = Class{__includes = BaseState}

function EntityRunState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('run')
    self.timer = 0
    self.randomDirection = math.random(2)
end

function EntityRunState:update(dt)
    local entity = self.entity
    local anim = self.entity.currentAnimation
    anim:update(dt)
    -- checks wheter and entity is aggressive or not and makes it behave accordingly
    if self.entity.aggressive then
        self:aggressiveAI()
    else
        self:passiveAI(dt)
    end

    entity:updatePosition(dt)
end

function EntityRunState:aggressiveAI()
    local entity = self.entity
    local player = self.entity.player

    -- always walk towards the player
    if entity.x > player.x then
        entity.dx = -entity.speed
        if entity.scaleX > 0 then
            entity.scaleX = -entity.scaleX
        end
    elseif entity.x < player.x then
        entity.dx = entity.speed
        if entity.scaleX < 0 then
            entity.scaleX = -entity.scaleX
        end
    end
    -- attacks if in range
    if entity:inRange(player) then
        entity.stateMachine:change('attack')
    end
end

function EntityRunState:passiveAI(dt)
    local entity = self.entity
    local player = self.entity.player

    self.timer = self.timer + dt
    -- if too far away walk towards the player
    if math.abs(entity.x - player.x) > WINDOW_WIDTH then
        if entity.x > player.x then
            entity.dx = -entity.speed
            if entity.scaleX > 0 then
                entity.scaleX = -entity.scaleX
            end
        elseif entity.x < player.x then
            entity.dx = entity.speed
            if entity.scaleX < 0 then
                entity.scaleX = -entity.scaleX
            end
        end
    -- else if less then one second has passed walk in a random direction
    elseif self.timer < 1 then
        if self.randomDirection == 2 then
            entity.dx = -entity.speed
            if entity.scaleX > 0 then
                entity.scaleX = -entity.scaleX
            end
        else
            entity.dx = entity.speed
            if entity.scaleX < 0 then
                entity.scaleX = -entity.scaleX
            end
        end
    -- else idle
    else
        entity.dx = 0
        entity.stateMachine:change('idle')
        self.timer = 0
    end
    -- if the player is too close attack
    if entity:inRange(player) then
        entity.stateMachine:change('attack')
    end
end

function EntityRunState:render()
    local anim = self.entity.currentAnimation
    -- renders current animation
    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
end
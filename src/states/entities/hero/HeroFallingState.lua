--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroFallingState = Class{__includes = BaseState}

function HeroFallingState:init(player)
    self.player = player
    self.player:changeAnimation('fall')
end

function HeroFallingState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- checks for movement inputs and changes scale and speed accordingly
    if player:moveRight() then
        player.dx = player.speed

        if player.scaleX < 0 then
            player.scaleX = -player.scaleX
        end
    elseif player:moveLeft() then
        player.dx = -player.speed

        if player.scaleX > 0 then
            player.scaleX = -player.scaleX
        end
    else
        player.dx = 0
    end
    -- if goes below the ground reset position and change status
    if player.y > FLOOR then
        player.dy = 0
        player.y = FLOOR
        player.gravity = 0
        if player.dx == 0 then
            player.stateMachine:change('idle')
        else
            player.stateMachine:change('run')
        end
    end
    -- checks for attack input
    if player:attack() then
        player.stateMachine:change('attack')
    end
    -- checks for shoot input
    if player:shoot() then
        player.stateMachine:change('ranged')
    end

    player:updatePosition(dt)
end

function HeroFallingState:render()
    local anim = self.player.currentAnimation
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
end
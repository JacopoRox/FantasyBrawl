--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroIdleState = Class{__includes = BaseState}

function HeroIdleState:init(player)
    self.player = player
    self.player:changeAnimation('idle')
end

function HeroIdleState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- checks for jump inputs
    if player:moveUp() then
        player.dy = -player.jump
        player.gravity = GRAVITY
        player.stateMachine:change('jump')
    else
        player.dy = 0
        player.gravity = 0
    end
    -- checks for left/right movements
    if player:moveRight() then
        player.dx = player.speed
        player.stateMachine:change('run')

        if player.scaleX < 0 then
            player.scaleX = -player.scaleX
        end
    elseif player:moveLeft() then
        player.dx = -player.speed
        player.stateMachine:change('run')

        if player.scaleX > 0 then
            player.scaleX = -player.scaleX
        end
    else
        player.dx = 0
    end
    -- checks for attack input
    if player:attack() then
        player.stateMachine:change('attack')
    end
    -- checks for shoot input
    if player:shoot() then
        player.stateMachine:change('ranged')
    end
end

function HeroIdleState:render()
    local anim = self.player.currentAnimation
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
end
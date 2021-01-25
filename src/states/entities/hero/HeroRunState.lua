--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroRunState = Class{__includes = BaseState}

function HeroRunState:init(player)
    self.player = player
    self.player:changeAnimation('run')
end

function HeroRunState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation

    anim:update(dt)
    -- checks jump input
    if player:moveUp() then
        player.stateMachine:change('jump')
        player.dy = -player.jump
        player.gravity = GRAVITY
    end
    -- check left\right movement input
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
        player.stateMachine:change('idle')
        player.dx = 0
    end
    -- check attack input
    if player:attack() then
        player.stateMachine:change('attack')
    end
    -- check attack input
    if player:shoot() then
        player.stateMachine:change('ranged')
    end
    player:updatePosition(dt)
end

function HeroRunState:render()
    local anim = self.player.currentAnimation
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
end
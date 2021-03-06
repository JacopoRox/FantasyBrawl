--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroJumpingState = Class{__includes = BaseState}

function HeroJumpingState:init(player)
    self.player = player
    self.player:changeAnimation('jump')
end

function HeroJumpingState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- checks left/right movement inputs
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
    -- if dy goes positive change status to falling
    if player.dy > 0 then
        player.stateMachine:change('fall')
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

function HeroJumpingState:render()
    local anim = self.player.currentAnimation
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
end
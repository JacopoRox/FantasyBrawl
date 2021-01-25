--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroRangedState = Class{__includes = BaseState}

function HeroRangedState:init(player)
    self.player = player
    self.player:changeAnimation('ranged')
    -- interval of the animation is set to the attack speed of the player
    self.player.currentAnimation.interval = self.player.atkspeed
    -- can not move during shooting
    self.player.dx = 0
end

function HeroRangedState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- prevents going below the ground
    if player.y > FLOOR then
        player.dy = 0
        player.gravity = 0
        player.y = FLOOR
    end

    player:updatePosition(dt)
    -- once animation is played initiate a projectile and change state
    if anim.timesPlayed == 1 then
        -- initiate a projectile at the end of the animation
        table.insert(self.player.projectiles, Projectile(player))
        anim.timesPlayed = 0
        if player.dy < 0 then
            player.stateMachine:change('jump')
        elseif player.dy > 0 then
            player.stateMachine:change('fall')
        elseif player.dx ~= 0 then
            player.stateMachine:change('run')
        else
            player.stateMachine:change('idle')
        end
    end
end

function HeroRangedState:render()
    local anim = self.player.currentAnimation
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
end
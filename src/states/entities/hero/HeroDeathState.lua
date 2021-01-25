--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroDeathState = Class{__includes = BaseState}

function HeroDeathState:init(player)
    self.player = player
    self.player:goInvulnerable()
    self.player:changeAnimation('death')
    self.player.currentAnimation.interval = 0.13
end

function HeroDeathState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation

    anim:update(dt)
    -- if the animation is over the player is flagged as dead
    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        player.dead = true
        anim.currentFrame = #anim.frames
    end
    -- does not allow to go below the surface
    if player.y > FLOOR then
        player.dy = 0
        player.y = FLOOR
        player.gravity = 0
    end

    player:updatePosition(dt)
end

function HeroDeathState:render()
    local anim = self.player.currentAnimation
    -- renders current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY,
        self.player.scaleX, self.player.scaleY, true)
end
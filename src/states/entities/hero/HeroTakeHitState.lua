--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroTakeHitState = Class{__includes = BaseState}

function HeroTakeHitState:init(player)
    self.player = player
    self.player:goInvulnerable(1)
    self.player:changeAnimation('take hit')
    self.player.dx = 0
end

function HeroTakeHitState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- if goes below the ground reset position and change status
    if player.y > FLOOR then
        player.dy = 0
        player.y = FLOOR
        player.gravity = 0
    end
    -- once animation is played change current status
    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        if player.health == 0 then
            player.stateMachine:change('death')
        elseif player.y ~= FLOOR then
            player.stateMachine:change('fall')
        else
            player.stateMachine:change('idle')
        end
    end
    player:updatePosition(dt)
end

function HeroTakeHitState:render()
    local anim = self.player.currentAnimation

    if anim.currentFrame == 2 then
        --set shader to create a white silhoutte on the second frame
        love.graphics.setShader(gShaders['white'])
    end
    -- render current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
    --reset a default shader
    love.graphics.setShader()
end
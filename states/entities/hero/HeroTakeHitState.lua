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

    if player.y > FLOOR then
        player.dy = 0
        player.y = FLOOR
        player.gravity = 0
    end

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
        --set shader to create a white silhoutte
        love.graphics.setShader(gShaders['white'])
    end

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
    --reset a default shader
    love.graphics.setShader()

    self.player.healthbar:render()
end
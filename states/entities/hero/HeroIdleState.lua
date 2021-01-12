HeroIdleState = Class{__includes = BaseState}

function HeroIdleState:init(player)
    self.player = player
    self.player:changeAnimation('idle')
end

function HeroIdleState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)

    if love.keyboard.PressedThisFrame(JUMP) or love.keyboard.isDown(JUMP) then
        player.dy = -player.jump
        player.gravity = GRAVITY
        player.stateMachine:change('jump')
    else
        player.dy = 0
        player.gravity = 0
    end

    if love.keyboard.isDown(RIGHT) and (LastPressed ~= LEFT or not love.keyboard.isDown(LEFT)) then
        player.dx = player.speed
        player.stateMachine:change('run')

        if player.scaleX < 0 then
            player.scaleX = -player.scaleX
        end
    elseif love.keyboard.isDown(LEFT) and (LastPressed ~= RIGHT or not love.keyboard.isDown(RIGHT)) then
        player.dx = -player.speed
        player.stateMachine:change('run')

        if player.scaleX > 0 then
            player.scaleX = -player.scaleX
        end
    else
        player.dx = 0
    end

    if love.keyboard.PressedThisFrame(STRIKE) then
        player.stateMachine:change('attack')
    end

    if love.keyboard.PressedThisFrame(RANGED) and player.ranged then
        player.stateMachine:change('ranged')
    end
end

function HeroIdleState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)

    self.player.healthbar:render()
end
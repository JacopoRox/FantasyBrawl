HeroJumpingState = Class{__includes = BaseState}

function HeroJumpingState:init(player)
    self.player = player
    self.player:changeAnimation('jump')
end

function HeroJumpingState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)

    if love.keyboard.isDown(RIGHT) and (LastPressed ~= LEFT or not love.keyboard.isDown(LEFT)) then
        player.dx = player.speed

        if player.scaleX < 0 then
            player.scaleX = -player.scaleX
        end
    elseif love.keyboard.isDown(LEFT) and (LastPressed ~= RIGHT or not love.keyboard.isDown(RIGHT)) then
        player.dx = -player.speed

        if player.scaleX > 0 then
            player.scaleX = -player.scaleX
        end
    else
        player.dx = 0
    end

    if player.dy > 0 then
        player.stateMachine:change('fall')
    end

    if love.keyboard.PressedThisFrame(STRIKE) then
        player.stateMachine:change('attack')
    end

    if love.keyboard.PressedThisFrame(RANGED) and player.ranged then
        player.stateMachine:change('ranged')
    end

    player:updatePosition(dt)
end

function HeroJumpingState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)

    self.player.healthbar:render()
end
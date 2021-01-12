HeroFallingState = Class{__includes = BaseState}

function HeroFallingState:init(player)
    self.player = player
    self.player:changeAnimation('fall')
end

function HeroFallingState:update(dt)
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

    if love.keyboard.PressedThisFrame(STRIKE) then
        player.stateMachine:change('attack')
    end

    if love.keyboard.PressedThisFrame(RANGED) and player.ranged then
        player.stateMachine:change('ranged')
    end

    player:updatePosition(dt)
end

function HeroFallingState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
    
    self.player.healthbar:render()
end
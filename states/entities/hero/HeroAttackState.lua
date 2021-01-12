HeroAttackState = Class{__includes = BaseState}

function HeroAttackState:init(player)
    self.player = player
    self.level = self.player.level
    self.player:changeAnimation('attack' .. tostring(math.random(2)))
    self.player.currentAnimation.interval = self.player.atkspeed

    self.hitbox = self.player:calculateHitbox()
end

function HeroAttackState:update(dt)
    local player = self.player
    local level = self.level
    local anim = self.player.currentAnimation
    anim:update(dt)

    if player.atkmove then
        if (love.keyboard.isDown(RIGHT) and (LastPressed ~= LEFT or not love.keyboard.isDown(LEFT))) and player.scaleX > 0 then
            player.dx = player.speed
        elseif (love.keyboard.isDown(LEFT) and (LastPressed ~= RIGHT or not love.keyboard.isDown(RIGHT))) and player.scaleX < 0 then
            player.dx = -player.speed
        else
            player.dx = 0
        end

        if (love.keyboard.PressedThisFrame(JUMP) or love.keyboard.isDown(JUMP)) and player.dy == 0 then
            player.dy = -player.jump
            player.gravity = GRAVITY
        end
    else
        player.dx = 0
    end

    if player.y > FLOOR then
        player.dy = 0
        player.gravity = 0
        player.y = FLOOR
    end

    player:updatePosition(dt)
    self:updateHitbox()

    if anim.currentFrame > player.atkframe then
        for k, entity in pairs(level.entities) do
            if self.hitbox:collides(entity.hurtbox) then
                entity:damage(player.strenght)
            end
        end
    end

    if anim.timesPlayed == 1 then
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

function HeroAttackState:updateHitbox()
    local player = self.player
    local hitboxX, hitboxY

    if player:getDirection() == 'right' then
        hitboxX = player.hurtbox.x + player.hurtbox.width
        hitboxY = player.hurtbox.y
    else
        hitboxX = player.hurtbox.x - player.atkrange
        hitboxY = player.hurtbox.y
    end

    self.hitbox:update(hitboxX, hitboxY)
end

function HeroAttackState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY,
        self.player.scaleX, self.player.scaleY, true)
    --self.hitbox:render()
    self.player.healthbar:render()
end
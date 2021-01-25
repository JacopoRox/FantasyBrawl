--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

HeroAttackState = Class{__includes = BaseState}

function HeroAttackState:init(player)
    self.player = player
    self.level = self.player.level
    -- animation is set to one random attack animation
    self.player:changeAnimation('attack' .. tostring(math.random(2)))
    -- the animation speed is equal to the attack speed of the player
    self.player.currentAnimation.interval = self.player.atkspeed
    -- when entering the attack state an hitbox is calculated
    self.hitbox = self.player:calculateHitbox()
end

function HeroAttackState:update(dt)
    local player = self.player
    local level = self.level
    local anim = self.player.currentAnimation
    anim:update(dt)
    -- if the hero can move during attacks this logic is executed
    if player.atkmove then
        if player:moveRight() and player.scaleX > 0 then
            player.dx = player.speed
        elseif player:moveLeft() and player.scaleX < 0 then
            player.dx = -player.speed
        else
            player.dx = 0
        end

        if player:moveUp() and player.dy == 0 then
            player.dy = -player.jump
            player.gravity = GRAVITY
        end
    else
        player.dx = 0
    end
    -- if goes below the floor position is reset
    if player.y > FLOOR then
        player.dy = 0
        player.gravity = 0
        player.y = FLOOR
    end

    player:updatePosition(dt)
    self:updateHitbox()
    -- if the animation is at the attack frame collisions are checked
    if anim.currentFrame > player.atkframe then
        for k, entity in pairs(level.entities) do
            if self.hitbox:collides(entity.hurtbox) then
                entity:damage(player.strenght)
            end
        end
    end
    -- once the animation is player the status is changed
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
    -- updates hitbox based on player position
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
    -- renders the current animation
    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY,
        self.player.scaleX, self.player.scaleY, true)
    --self.hitbox:render()
end
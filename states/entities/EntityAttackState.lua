EntityAttackState = Class{__includes = BaseState}

function EntityAttackState:init(entity)
    self.entity = entity
    self.entity:face(self.entity.player)
    self.entity:changeAnimation('attack' .. tostring(math.random(2)))
    self.entity.currentAnimation.interval = self.entity.atkspeed

    self.hitbox = entity:calculateHitbox()
end

function EntityAttackState:update(dt)
    local entity = self.entity
    local player = self.entity.player
    local anim = self.entity.currentAnimation
    anim:update(dt)
    -- if the entity can move during attacks and the player is out of range the entity
    -- the entity can close the distance but not changing direction
    if entity.atkmove and not entity:inRange(player) then
        if entity.x > player.x and entity:getDirection() == 'left' then
            entity.dx = -entity.speed
        elseif entity.x < player.x and entity:getDirection() == 'right' then
            entity.dx = entity.speed
        else
            entity.dx = 0
        end

        entity:updatePosition(dt)
    end

    self:updateHitbox()

    if anim.currentFrame >= entity.atkframe then
        if self.hitbox:collides(player.hurtbox) then
            player:damage(entity.strenght)
        end
    end

    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        entity.stateMachine:change('idle')
    end
end

function EntityAttackState:updateHitbox()
    local entity = self.entity
    local hitboxX, hitboxY

    if entity.scaleX > 0 then
        hitboxX = entity.hurtbox.x + entity.hurtbox.width
        hitboxY = entity.hurtbox.y
    else
        hitboxX = entity.hurtbox.x - entity.atkrange
        hitboxY = entity.hurtbox.y
    end

    self.hitbox:update(hitboxX, hitboxY)
end

function EntityAttackState:render()
    local anim = self.entity.currentAnimation

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
    --self.hitbox:render()
    self.entity.healthbar:render()
end
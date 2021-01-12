EntityTakeHitState = Class{__includes = BaseState}

function EntityTakeHitState:init(entity)
    self.entity = entity
    self.entity:goInvulnerable()
    self.entity:changeAnimation('take hit')
    self.entity.dx = 0
end

function EntityTakeHitState:update(dt)
    local entity = self.entity
    local anim = self.entity.currentAnimation
    anim:update(dt)

    if entity.y > FLOOR then
        entity.dy = 0
        entity.y = FLOOR
        entity.gravity = 0
    end

    entity:updatePosition(dt)

    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        if entity.health == 0 then
            entity.stateMachine:change('death')
        else
            entity.stateMachine:change('idle')
            entity:goInvulnerable(entity.restTime)
        end
    end
end

function EntityTakeHitState:render()
    local anim = self.entity.currentAnimation

    if anim.currentFrame == 2 then
        --set shader to create a white silhoutte
        love.graphics.setShader(gShaders['white'])
    end

    anim:render(self.entity.x + self.entity.offsetX, self.entity.y + self.entity.offsetY, 
        self.entity.scaleX, self.entity.scaleY, true)
    --reset a default shader
    love.graphics.setShader()

    self.entity.healthbar:render()
end
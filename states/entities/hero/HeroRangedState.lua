HeroRangedState = Class{__includes = BaseState}

function HeroRangedState:init(player)
    self.player = player
    self.player:changeAnimation('ranged')
    self.player.currentAnimation.interval = self.player.atkspeed
    self.hitbox = self.player:calculateHitbox()
    self.player.dx = 0
end

function HeroRangedState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation
    anim:update(dt)

    if player.y > FLOOR then
        player.dy = 0
        player.gravity = 0
        player.y = FLOOR
    end

    player:updatePosition(dt)

    if anim.timesPlayed == 1 then
        -- initiate a projectile at the end of the animation
        table.insert(self.player.projectiles, Projectile(player))
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

function HeroRangedState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY, 
        self.player.scaleX, self.player.scaleY, true)
    self.player.healthbar:render()
end
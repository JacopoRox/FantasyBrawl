HeroDeathState = Class{__includes = BaseState}

function HeroDeathState:init(player)
    self.player = player
    self.player:goInvulnerable()
    self.player:changeAnimation('death')
    self.player.currentAnimation.interval = 0.13
end

function HeroDeathState:update(dt)
    local player = self.player
    local anim = self.player.currentAnimation

    anim:update(dt)

    if anim.timesPlayed == 1 then
        anim.timesPlayed = 0
        player.dead = true
        anim.currentFrame = #anim.frames
    end

    if player.y > FLOOR then
        player.dy = 0
        player.y = FLOOR
        player.gravity = 0
    end

    player:updatePosition(dt)
end

function HeroDeathState:render()
    local anim = self.player.currentAnimation

    anim:render(self.player.x + self.player.offsetX, self.player.y + self.player.offsetY,
        self.player.scaleX, self.player.scaleY, true)
end
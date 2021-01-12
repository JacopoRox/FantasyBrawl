BackgroundPlayState = Class{__includes = BaseState}

function BackgroundPlayState:init(background)
    self.background = background
end

function BackgroundPlayState:enter(player)
    self.player = player
end

function BackgroundPlayState:update(dt)
    local layers = self.background.layers
    for i = 1, #layers do
        layers[i].speed = -self.player.dx * layers[i].speedf
        layers[i].x = (layers[i].x + layers[i].speed * dt) % - self.background.loopingpoint
    end
end
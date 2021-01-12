BackgroundSelectionState = Class{__includes = BaseState}

function BackgroundSelectionState:init(background)
    self.background = background
end

function BackgroundSelectionState:update(dt)
    local layers = self.background.layers
    for i = 1, #layers do
        layers[i].speed = -200 * layers[i].speedf
        layers[i].x = (layers[i].x + layers[i].speed * dt) % -self.background.loopingpoint
    end
end

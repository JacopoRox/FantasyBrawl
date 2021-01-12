Background = Class{}

function Background:init(type)
    self.layers = self:generateLayers(type)
    self.scale = 0.8
    self.loopingpoint = self.layers[1].texture:getWidth() * self.scale
    self.offset = 150
    self.stateMachine = StateMachine {
        ['play'] = function () return BackgroundPlayState(self) end,
        ['selection'] = function () return BackgroundSelectionState(self) end
    }
    self.stateMachine:change('selection')
end

function Background:generateLayers(type)
    local layers = {}
    for k, v in pairs(gTextures[type]) do
        layers[k] = {
            texture = v,
            x = 0,
            speedf = k/10
        }
    end
    return layers
end

function Background:update(dt)
    self.stateMachine:update(dt)
end

function Background:render()
    local layers = self.layers

    for i = 1, #layers do
        love.graphics.draw(layers[i].texture, layers[i].x, 0, 
            0, self.scale, self.scale, 0, self.offset)
        love.graphics.draw(layers[i].texture, layers[i].x + self.loopingpoint, 0, 
            0, self.scale, self.scale, 0, self.offset)
    end
end


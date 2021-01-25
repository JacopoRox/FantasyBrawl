--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

BackgroundPlayState = Class{__includes = BaseState}

function BackgroundPlayState:init(background)
    self.background = background
end

function BackgroundPlayState:enter(player)
    -- when entering the play state the player is passed to the background
    self.player = player
end

function BackgroundPlayState:update(dt)
    -- updates the position of the background according to the player's movement
    -- each layer scrolls at a different speed
    local layers = self.background.layers
    for i = 1, #layers do
        layers[i].speed = -self.player.dx * layers[i].speedf
        layers[i].x = (layers[i].x + layers[i].speed * dt) % - self.background.loopingpoint
    end
end
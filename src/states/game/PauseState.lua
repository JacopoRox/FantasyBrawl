--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.level = params.level
    self.player = self.level.player
    self.background = params.background
    self.camera = params.camera
end

function PauseState:update()
    -- if ESC is pressed goes back to play state
    -- passing in the player, the level and the background at their current state
    if love.keyboard.PressedThisFrame(ESC) then
        gStateMachine:change('play', {
            player = self.player,
            level = self.level,
            background = self.background,
            camera = self.camera
        })
    end
end

function PauseState:render()
    local camera = self.camera

    self.background:render()
    -- camera fallows the player
    love.graphics.translate(camera.x, 0)
    self.player:render()
    self.level:render()
    love.graphics.translate(-camera.x, 0)
    -- displays that the game is paused
    love.graphics.setColor(150/225, 0/255, 24/255)
    love.graphics.printf('Pause', gFonts['medium-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/2 - 50), WINDOW_WIDTH, 'center')
    love.graphics.printf('Press esc to resume', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/3 + 100), WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
end
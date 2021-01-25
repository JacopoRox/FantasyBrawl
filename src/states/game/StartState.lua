--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = Background('forest')
end

function StartState:update(dt)
    -- updates background
    self.background:update(dt)
    -- if ENTER is pressed change the game state to selection
    if love.keyboard.PressedThisFrame(ENTER) then
        gStateMachine:change('selection', self.background)
    end
end

function StartState:render()
    -- renders the background
    self.background:render()
    -- renders the name of the game
    love.graphics.setColor(150/225, 0/255, 24/255)
    love.graphics.printf('Fantasy Brawl', gFonts['big-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/2 - 50), WINDOW_WIDTH, 'center')
    -- renders an indication on how to start the game
    love.graphics.printf('Press enter to play', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/3 + 200), WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
end
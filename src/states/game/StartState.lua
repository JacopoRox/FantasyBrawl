--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = Background('forest')
    self.menu = {SIENNA, 'Play\n', CARMINE, 'Options\n', CARMINE, 'Exit\n'}
    self.index = 1
end

function StartState:update(dt)
    -- updates background
    self.background:update(dt)

    -- if ENTER is pressed change the game state to selection
    if love.keyboard.PressedThisFrame(ENTER) then
        gStateMachine:change('selection', self.background)
    -- else if ESC is pressed close the game
    elseif love.keyboard.PressedThisFrame(ESC) then
        love.event.quit()
    end

    if self:arrowUp() then
        self.index = math.max(1, self.index + 1 % 4)
    elseif self:arrowDown() then
        self.index = math.max(1, self.index - 1 % 4)
    end
end

function StartState:arrowUp()
    return love.keyboard.PressedThisFrame(UP)
end

function StartState:arrowDown()
    return love.keyboard.PressedThisFrame(DOWN)
end

function StartState:render()
    -- renders the background
    self.background:render()
    -- renders the name of the game
    love.graphics.printf({CARMINE, 'Fantasy Brawl'}, gFonts['big-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    -- renders an indication on how to start the game
    love.graphics.printf(self.menu, gFonts['medium-dungeon-font'], 0, 250, GAME_WIDTH, 'center')
end
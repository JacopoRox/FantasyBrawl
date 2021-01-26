--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = Background('forest')
    self.box = Box(540, 315, 20, 20, 'fill')
end

function StartState:update(dt)
    local box = self.box

    -- updates background
    self.background:update(dt)

    if love.keyboard.PressedThisFrame(UP) then
        box.y = math.max(315, box.y - 100)
    elseif love.keyboard.PressedThisFrame(DOWN) then
        box.y = math.min(515, box.y + 100)
    end

    -- if ENTER is pressed change the game state to selection
    if love.keyboard.PressedThisFrame(ENTER) then
        gStateMachine:change('selection', self.background)
    -- else if ESC is pressed close the game
    elseif love.keyboard.PressedThisFrame(ESC) then
        love.event.quit()
    end
end

function StartState:arrowUp()
    return love.keyboard.PressedThisFrame(UP)
end

function StartState:render()
    -- renders the background
    self.background:render()
    -- renders the name of the game
    love.graphics.setColor(CARMINE)
    love.graphics.printf('Fantasy Brawl', gFonts['big-dungeon-font'],
        0, 150, WINDOW_WIDTH, 'center')
    -- renders an indication on how to start the game
    love.graphics.printf('Play', gFonts['medium-dungeon-font'],
        0, 300, WINDOW_WIDTH, 'center')
    love.graphics.printf('Options', gFonts['medium-dungeon-font'],
        0, 400, WINDOW_WIDTH, 'center')
    love.graphics.printf('Exit', gFonts['medium-dungeon-font'],
        0, 500, WINDOW_WIDTH, 'center')
    self.box:render()
    love.graphics.setColor(WHITE)
end
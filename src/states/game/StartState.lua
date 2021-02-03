--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = Background('forest')
    self.menu = Menu(MENU_DEFS['start'])
end

function StartState:update(dt)
    local index = self.menu:getIndex()
    -- updates background
    self.background:update(dt)
    -- updates the menu
    self.menu:update(dt)
    -- if ENTER is pressed change the game state according to the menu index
    if love.keyboard.PressedThisFrame(ENTER) then
        if index == 1 then
            gStateMachine:change('selection', self.background)
        elseif index == 2 then
            return
        else
            return
        end
    end
end

function StartState:render()
    -- renders the background
    self.background:render()
    -- renders the name of the game
    love.graphics.printf({CARMINE, 'Fantasy Brawl'}, gFonts['big-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.menu:render()
end
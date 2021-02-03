--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gBackground = Background('forest')
    self.menu = Menu(MENU_DEFS['start'])
end

function StartState:update(dt)
    local index = self.menu:getIndex()
    -- updates background
    gBackground:update(dt)
    -- updates the menu
    self.menu:update(dt)
end

function StartState:render()
    -- renders the background
    gBackground:render()
    -- renders the name of the game
   -- love.graphics.printf({CARMINE, 'Fantasy Brawl'}, gFonts['big-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.menu:render()
end
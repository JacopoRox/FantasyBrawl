--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

StartState = Class{__includes = BaseState}

function StartState:init()
    gBackground = Background('forest')
    self.menu = Menu()
    self.menu.stateMachine:change('start')
end

function StartState:update(dt)
    -- updates background
    gBackground:update(dt)
    -- updates the menu
    self.menu:update(dt)
end

function StartState:render()
    -- renders the background
    gBackground:render()
    -- renders the start menu
    self.menu:render()
end
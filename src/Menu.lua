--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Menu = Class{}

function Menu:init()
    self.stateMachine = StateMachine {
        ['start'] = function () return MenuStartState(self, MENU_DEFS['start']) end,
        ['options'] = function () return MenuOptionsState(self, MENU_DEFS['options']) end
    }
end

function Menu:update(dt)
    self.stateMachine:update(dt)
end

function Menu:render()
    self.stateMachine:render()
end
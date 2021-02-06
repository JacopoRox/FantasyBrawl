--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Menu = Class{}

function Menu:init()
    self.stateMachine = StateMachine {
        ['start'] = function () return MenuStartState(self) end,
        ['options'] = function () return MenuOptionsState(self) end,
        ['commands'] = function () return MenuCommandsState(self) end,
        ['volume'] = function () return MenuVolumeState(self) end,
        ['graphics'] = function () return MenuGraphicsState(self) end
    }
end

function Menu:update(dt)
    self.stateMachine:update(dt)
end

function Menu:render()
    self.stateMachine:render()
end
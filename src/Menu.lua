--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Menu = Class{}

function Menu:init(def)
    self.index = 1

    -- the options to be displayed
    self.strings = def.strings

    -- defines how fast options can be switched, default is 0.2 seconds
    self.timer = 0
    self.interval = def.interval or 0.2

    -- colors used to render the options
    self.color = def.color or {0, 0, 0}
    self.selection = def.selection or {1, 1, 1}
end

function Menu:update(dt)
    -- timer to keep track of time
    self.timer = self.timer + dt
    -- checks input and switch index accordingly resetting timer
    if love.keyboard.PressedThisFrame(DOWN) or (love.keyboard.isDown(DOWN) and self.timer > self.interval) then
        self.index = math.max(1, (self.index + 1) % (#self.strings + 1))
        self.timer = 0
    elseif love.keyboard.PressedThisFrame(UP) or (love.keyboard.isDown(UP) and self.timer > self.interval) then
        self.index = self.index - 1
        if self.index == 0 then self.index = 3 end
        self.timer = 0
    end
end

function Menu:getIndex()
    return self.index
end

function Menu:render()
    -- renders all options
    for k, v in pairs(self.strings) do
        if k ~= self.index then
            love.graphics.printf({self.color, v.string}, v.font, v.x, v.y, v.limit, v.align)
        else
            love.graphics.printf({self.selection, v.string}, v.font, v.x, v.y, v.limit, v.align)
        end
    end
end
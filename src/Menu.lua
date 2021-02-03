--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Menu = Class{}

function Menu:init(def)
    self.index = 1

    -- the options to be displayed
    self.title = def.title
    self.strings = def.strings

    -- defines how fast options can be switched, default is 0.2 seconds
    self.timer = 0
    self.interval = def.interval or 0.2

    -- colors used to render the options
    self.color = def.color or {0, 0, 0}
    self.selection = def.selection or {1, 1, 1}

    self.stateMachine = StateMachine {
        ['start'] = function () return MenuStartState(self) end,
        ['options'] = function () return MenuOptionsState(self) end
    }
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

    -- if ENTER is pressed change the game state according to the menu index
    if love.keyboard.PressedThisFrame(ENTER) then
        if index == 1 then
            gStateMachine:change('selection')
        elseif index == 2 then
            gStateMachine:change('options')
        else
            love.event.quit()
        end
    end
end

function Menu:getIndex()
    return self.index
end

function Menu:render()
    local title = self.title

    -- renders title
    love.graphics.printf({self.color, title.string}, title.font, title.x, title.y, title.limit, title.align)
    -- renders all options
    for k, v in pairs(self.strings) do
        if k ~= self.index then
            love.graphics.printf({self.color, v.string}, v.font, v.x, v.y, v.limit, v.align)
        else
            love.graphics.printf({self.selection, v.string}, v.font, v.x, v.y, v.limit, v.align)
        end
    end
end
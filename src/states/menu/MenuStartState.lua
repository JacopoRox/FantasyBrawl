--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuStartState = Class{__includes = BaseState}

function MenuStartState:init(menu, def)
    -- reference to the menu
    self.menu = menu

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
end

function MenuStartState:update(dt)
    -- timer to keep track of time
    self.timer = self.timer + dt
    -- checks input and switch index accordingly resetting timer
    if love.keyboard.PressedThisFrame(DOWN) or (love.keyboard.isDown(DOWN) and self.timer > self.interval) then
        self.index = math.max(1, (self.index + 1) % (#self.strings + 1))
        self.timer = 0
    elseif love.keyboard.PressedThisFrame(UP) or (love.keyboard.isDown(UP) and self.timer > self.interval) then
        self.index = self.index - 1
        if self.index == 0 then self.index = #self.strings end
        self.timer = 0
    end

    -- if ENTER is pressed change the game state according to the menu index
    if love.keyboard.PressedThisFrame(ENTER) then
        if self.index == 1 then
            gStateMachine:change('selection')
        elseif self.index == 2 then
            self.menu.stateMachine:change('options')
        else
            love.event.quit()
        end
    end
end

function MenuStartState:render()
    -- renders title
    love.graphics.printf({self.color, self.title.string}, self.title.font, self.title.x, self.title.y, self.title.limit, self.title.align)
    -- renders all options
    for k, v in pairs(self.strings) do
        if k ~= self.index then
            love.graphics.printf({self.color, v.string}, v.font, v.x, v.y, v.limit, v.align)
        else
            love.graphics.printf({self.selection, v.string}, v.font, v.x, v.y, v.limit, v.align)
        end
    end
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuCommandsState = Class{__includes = BaseState}

function MenuCommandsState:init(menu, def)
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
    self.color = def.color or BLACK
    self.highlight = def.highlight or WHITE
    self.selColor = def.selColor or VIOLET

    -- keep track of wheter we are selecting or not
    self.selection = false
end

function MenuCommandsState:update(dt)
    -- timer to keep track of time
    self.timer = self.timer + dt
    -- checks input and switch index accordingly resetting timer
    if not self.selection and love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('options')
    end

    if self.selection then
        if love.keyboard.PressedThisFrame(ESC) then
            self.selection = false
            self.selected = nil
        elseif self.index == 1 then
            STRIKE = self:assignKey() or STRIKE
            self.strings[1].string = 'Attack: '..GetKey(STRIKE)
        elseif self.index == 2 then
            RANGED = self:assignKey() or RANGED
            self.strings[2].string = 'Shoot: '..GetKey(RANGED)
        elseif self.index == 3 then
            JUMP = self:assignKey() or JUMP
            self.strings[3].string = 'Jump: '..GetKey(JUMP)
        elseif self.index == 4 then
            RIGHT = self:assignKey() or RIGHT
            self.strings[4].string = 'Move Right: '..GetKey(RIGHT)
        elseif self.index == 5 then
            LEFT = self:assignKey() or LEFT
            self.strings[5].string = 'Move Left: '..GetKey(LEFT)
        end
    -- if ENTER is pressed change the game state according to the menu index
    elseif love.keyboard.PressedThisFrame(ENTER) then
        self.selection = true
    elseif love.keyboard.PressedThisFrame(DOWN) or (love.keyboard.isDown(DOWN) and self.timer > self.interval) then
        self.index = math.max(1, (self.index + 1) % (#self.strings + 1))
        self.timer = 0
    elseif love.keyboard.PressedThisFrame(UP) or (love.keyboard.isDown(UP) and self.timer > self.interval) then
        self.index = self.index - 1
        if self.index == 0 then self.index = #self.strings end
        self.timer = 0
    end
end

-- return the last pressed key if the key was pressed this frame
function MenuCommandsState:assignKey()
    local key = (love.keyboard.pressed[LastPressed] and LastPressed)
    if key then return key else return false end
end

function MenuCommandsState:render()
    -- renders title
    love.graphics.printf({self.color, self.title.string}, self.title.font, self.title.x, self.title.y, self.title.limit, self.title.align)
    -- renders all options
    for k, v in pairs(self.strings) do
        if k == self.index then
            if self.selection then
                love.graphics.printf({self.selColor, v.string}, v.font, v.x, v.y, v.limit, v.align)
            else
                love.graphics.printf({self.highlight, v.string}, v.font, v.x, v.y, v.limit, v.align)
            end
        else
            love.graphics.printf({self.color, v.string}, v.font, v.x, v.y, v.limit, v.align)
        end
    end
end
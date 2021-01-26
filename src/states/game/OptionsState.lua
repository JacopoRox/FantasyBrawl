--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

OptionsState = Class{__includes = BaseState}

function OptionsState:init()
    self.volume = VOLUME
end

function OptionsState:enter(params)
    self.background = params.background
    self.level = params.level or nil
    if self.level then
        self.player = self.level.player
        self.camera = params.camera
    end
end

function OptionsState:update(dt)
    self.background:update(dt)
end

function OptionsState:render()
    self.background:render()
    if self.level then
        love.graphics.translate(self.camera.x, 0)
        self.player:render()
        self.level:render()
        love.graphics.translate(-self.camera.x, 0)
    end

    love.graphics.printf('Volume:', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/2), WINDOW_WIDTH, 'center')
    love.graphics.setColor(Carmine())
    love.graphics.rectangle('line', WINDOW_WIDTH/2 + 50, WINDOW_HEIGHT/2, width, height)
    love.graphics.rectangle('fill', WINDOW_WIDTH/2 + 50, WINDOW_HEIGHT/2, width, height)
    love.graphics.rectangle()
end
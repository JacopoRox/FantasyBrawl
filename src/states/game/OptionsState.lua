--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

OptionsState = Class{__includes = BaseState}

function OptionsState:init()
    self.volume = VOLUME
    self.width = 100
    self.height = 20
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

function OptionsState:displayVolume()
    love.graphics.printf('Volume:', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/2), WINDOW_WIDTH, 'center')

    love.graphics.setColor(CARMINE)
    love.graphics.rectangle('line', WINDOW_WIDTH/2 + 50, WINDOW_HEIGHT/2, self.width, self.height)
    love.graphics.rectangle('fill', WINDOW_WIDTH/2 + 50, WINDOW_HEIGHT/2, self.width * self.volume, self.height)
    love.graphics.setColor(WHITE)
end

function OptionsState:displayCommands()
    love.graphics.printf(' Arrows : Run\nSpacebar: Jump\nS: Attack\nD: Shoot', gFonts['smaller-dungeon-font'],
        0, 450, WINDOW_WIDTH, 'center')
end

function OptionsState:render()
    self.background:render()
    if self.level then
        love.graphics.translate(self.camera.x, 0)
        self.player:render()
        self.level:render()
        love.graphics.translate(-self.camera.x, 0)
    end
end
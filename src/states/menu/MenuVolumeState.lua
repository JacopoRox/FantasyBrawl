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
    self.menu = Menu(MENU_DEFS['options'])
end

function OptionsState:update(dt)
    gBackground:update(dt)
    self.menu:update(dt)
end

function OptionsState:displayVolume()
    love.graphics.printf('Volume:', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(GAME_HEIGHT/2), GAME_WIDTH, 'center')

    love.graphics.setColor(CARMINE)
    love.graphics.rectangle('line', GAME_WIDTH/2 + 50, GAME_HEIGHT/2, self.width, self.height)
    love.graphics.rectangle('fill', GAME_WIDTH/2 + 50, GAME_HEIGHT/2, self.width * self.volume, self.height)
    love.graphics.setColor(WHITE)
end

function OptionsState:displayCommands()
    love.graphics.printf(' Arrows : Run\nSpacebar: Jump\nS: Attack\nD: Shoot', gFonts['smaller-dungeon-font'],
        0, 450, GAME_WIDTH, 'center')
end

function OptionsState:render()
    gBackground:render()
    if self.level then
        love.graphics.push()
        love.graphics.translate(self.camera.x, 0)
        self.player:render()
        self.level:render()
        love.graphics.pop()
    end
    self.menu:render()
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.background = params.background
    self.player = params.player
    self.camera = params.camera
end

function GameOverState:update(dt)
    self.background:update(dt)
    -- enter selection state if enter is pressed
    if love.keyboard.PressedThisFrame(ENTER) then
        self.background.stateMachine:change('selection')
        gStateMachine:change('selection', self.background)
    end
end

function GameOverState:render()
    local camera = self.camera
    self.background:render()
    -- translate coordinate to fallow the player
    love.graphics.translate(camera.x, 0)
    self.player:render()
    love.graphics.translate(-camera.x, 0)
    -- displays GAME OVER fallowed by the score of the previous run
    love.graphics.setColor(CARMINE)
    love.graphics.printf('GAME OVER', gFonts['big-dungeon-font'],
        math.floor(0), math.floor(VIRTUAL_HEIGHT/3 - 100), VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Score: '..tostring(self.player.score), gFonts['medium-dungeon-font'],
        math.floor(0), math.floor(VIRTUAL_HEIGHT/3 + 100), VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press enter to try again', gFonts['medium-dungeon-font'],
        math.floor(0), math.floor(VIRTUAL_HEIGHT/3 + 200), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(WHITE)
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.player = params.player
    self.camera = params.camera
end

function GameOverState:update(dt)
    -- enter selection state if enter is pressed
    if love.keyboard.PressedThisFrame(ENTER) then
        gBackground.stateMachine:change('selection')
        gStateMachine:change('selection')
    end
end

function GameOverState:render()
    local camera = self.camera
    gBackground:render()
    -- translate coordinate to fallow the player
    love.graphics.translate(camera.x, 0)
    self.player:render()
    love.graphics.translate(-camera.x, 0)
    -- displays GAME OVER fallowed by the score of the previous run
    love.graphics.setColor(CARMINE)
    love.graphics.printf('Game Over', gFonts['big-dungeon-font'],
        math.floor(0), math.floor(GAME_HEIGHT/3 - 100), GAME_WIDTH, 'center')
    love.graphics.printf('Score: '..tostring(self.player.score), gFonts['medium-dungeon-font'],
        math.floor(0), math.floor(GAME_HEIGHT/3 + 100), GAME_WIDTH, 'center')
    love.graphics.printf('Press enter to try again', gFonts['medium-dungeon-font'],
        math.floor(0), math.floor(GAME_HEIGHT/3 + 200), GAME_WIDTH, 'center')
    love.graphics.setColor(WHITE)
end
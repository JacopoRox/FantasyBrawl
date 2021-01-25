--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
    self.player = params.player
    self.level = params.level or Level(self.player)
    self.camera = params.camera or Camera(self.player)
    self.background = params.background
    self.background.stateMachine:change('play', self.player)

    -- the player gets a reference to the level
    self.player.level = self.level
end

function PlayState:update(dt)
    -- updates all entities, the background and the camera
    self.player:update(dt)
    self.camera:update()
    self.level:update(dt)
    self.background:update(dt)
    -- the game gets paused if ESC is pressed
    if love.keyboard.PressedThisFrame(ESC) then
        gStateMachine:change('pause', {
            level = self.level,
            background = self.background,
            camera = self.camera
        })
    end
    -- if the player is dead the state is changed to GAME OVER
    if self.player.dead then
        gStateMachine:change('game-over', {
            player = self.player,
            background = self.background,
            camera = self.camera
        })
    end
end

function PlayState:render()
    local camera = self.camera
    -- renders the background, the player and the level to the screen
    self.background:render()
    -- the camera fallows the player's movements
    love.graphics.translate(camera.x, 0)
    self.player:render()
    self.level:render()
    love.graphics.translate(-camera.x, 0)
    -- displays the score and the level the player is in
    love.graphics.setColor(150/225, 0/255, 24/255)
    love.graphics.printf('Score: '.. tostring(self.player.score), gFonts['small-dungeon-font'],
        0, 100, WINDOW_WIDTH, 'center')
    love.graphics.printf('Level: '.. tostring(self.level.lvl), gFonts['medium-dungeon-font'],
        0, 20, WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
end
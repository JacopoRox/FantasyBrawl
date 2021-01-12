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
    self.player:update(dt)
    self.camera:update(dt)
    self.level:update(dt)
    self.background:update(dt)

    if love.keyboard.PressedThisFrame(ESC) then
        gStateMachine:change('pause', {
            level = self.level,
            background = self.background,
            camera = self.camera
        })
    end

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

    self.background:render()
    love.graphics.translate(camera.x, camera.y)
    self.player:render()
    self.level:render()
    love.graphics.translate(-camera.x, -camera.y)
    --love.graphics.line(0, WINDOW_HEIGHT - 13, WINDOW_WIDTH, WINDOW_HEIGHT - 13)
    love.graphics.setColor(150/225, 0/255, 24/255)
    love.graphics.printf('Score: '.. tostring(self.player.score), gFonts['small-dungeon-font'],
        0, 100, WINDOW_WIDTH, 'center')
    love.graphics.printf('Level: '.. tostring(self.player.lvl), gFonts['medium-dungeon-font'],
        0, 20, WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
end
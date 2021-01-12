StartState = Class{__includes = BaseState}

function StartState:init()
    self.background = Background('forest')
end

function StartState:update(dt)
    self.background:update(dt)

    if love.keyboard.PressedThisFrame('return') then
        gStateMachine:change('selection', self.background)
    end
end

function StartState:render()
    self.background:render()

    love.graphics.setColor(150/225, 0/255, 24/255)
    love.graphics.printf('Fantasy Brawl', gFonts['big-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/2 - 50), WINDOW_WIDTH, 'center')

    love.graphics.printf('Press enter to play', gFonts['small-dungeon-font'],
        math.floor(0), math.floor(WINDOW_HEIGHT/3 + 200), WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

require 'src/Dependencies'

function love.load()
    -- Initialize the pseudo random number generator
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    love.window.setTitle('Fantasy Brawl')

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    gStateMachine = StateMachine {
        ['start'] = function () return StartState() end,
        ['selection'] = function () return SelectionState() end,
        ['play'] = function () return PlayState() end,
        ['game-over'] = function () return GameOverState() end,
        ['pause'] = function () return PauseState() end
    }
    gStateMachine:change('start')

    love.audio.setVolume(0)
    gSounds['background']:setLooping(true)
    gSounds['background']:play()

    -- store last pressed and last released keys
    LastPressed = nil
    LastReleased = nil
    -- stores key pressed this frame
    love.keyboard.pressed = {}
end

function love.keyboard.PressedThisFrame(key)
    -- returns true if a key was pressed this frame
    return love.keyboard.pressed[key]
end

function love.keypressed(key)
    -- each time a key is pressed stores it as the last pressed and inside the pressed table
    LastPressed = key
    love.keyboard.pressed[key] = true
end

function love.keyreleased(key)
    -- store the last released key in a variable
    LastReleased = key
end

function love.update(dt)
    -- updates the current stateMachine
    gStateMachine:update(dt)
    -- empties the pressed table after all the logic is executed each frame
    love.keyboard.pressed = {}
end

function love.resize(w, h)
    WINDOW_WIDTH, WINDOW_HEIGHT = w, h
    push:resize(w, h)
end

function love.draw()
    push:apply('start')
    gStateMachine:render()
    push:apply('end')
end
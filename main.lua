--[[
    FantasyBrawl
    Author: Jacopo Rossi
    CS50 final project
]]

require 'constants'
require 'Dependencies'

function love.load()
    -- Initialize the pseudo random number generator
    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.window.setTitle('Fantasy Brawl')

    gStateMachine = StateMachine {
        ['start'] = function () return StartState() end,
        ['selection'] = function () return SelectionState() end,
        ['play'] = function () return PlayState() end,
        ['game-over'] = function () return GameOverState() end,
        ['pause'] = function () return PauseState() end
    }

    gStateMachine:change('start')
    love.audio.setVolume(0.4)
    gSounds['background']:setLooping(true)
    gSounds['background']:play()

    LastPressed = nil
    LastReleased = nil
    love.keyboard.pressed = {}
end

function love.keyboard.PressedThisFrame(key)
    return love.keyboard.pressed[key]
end

function love.keypressed(key)
    LastPressed = key
    love.keyboard.pressed[key] = true
end

function love.keyreleased(key)
    LastReleased = key
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.pressed = {}
end

function love.draw()
    gStateMachine:render()

    love.graphics.setColor(0, 0, 0)
    --love.graphics.print(tostring(love.timer.getDelta()))
    --love.graphics.print("Last Pressed = " .. tostring(LastPressed), 0, 50)
    --love.graphics.print("Last Released = " .. tostring(LastReleased), 0, 100)
    love.graphics.setColor(1, 1, 1)
end
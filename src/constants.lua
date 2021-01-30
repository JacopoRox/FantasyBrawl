--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
GAME_WIDTH, GAME_HEIGHT = 960, 540

FLOOR = GAME_HEIGHT - 80
GRAVITY = 2000

-- default value
VOLUME = 0.5

-- colors
CARMINE = {150/225, 0/255, 24/255}
SIENNA = {32/225, 0, 0}
WHITE = {1, 1, 1}
BLACK = {0, 0, 0}

-- default action keys
JUMP = 'space'
LEFT = 'left'
RIGHT = 'right'
STRIKE = 's'
RANGED = 'd'
ENTER = 'return'
ESC = 'escape'
UP = 'up'
DOWN = 'down'
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 1280, 600

FLOOR = 520
GRAVITY = 2000

-- default value
VOLUME = 0.5

-- colors
CARMINE = {150/225, 0/255, 24/255}
WHITE = {1, 1, 1}

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
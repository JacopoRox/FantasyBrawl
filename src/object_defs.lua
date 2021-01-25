--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

-- raw data the define objects
GAME_OBJECT_DEFS = {
    ['projectiles'] = {
        ['huntress'] = {
            strenght = 20,
            speed = 600,
            width = 43,
            hitbox = {},
            height = 2
        },
        ['goblin'] = {
            strenght = 80,
            speed = 400,
            width = 12,
            height = 12,
            hitbox = {
                offsetX = 1,
                offsetY = 10
            },
            explode = true,
            y = WINDOW_HEIGHT - 32
    },
        ['skeleton'] = {
            strenght = 10,
            speed = 300,
            width = 15,
            height = 15,
            hitbox = {
                offsetX = 3,
                offsetY = 15
            },
            explode = true
        },
        ['mushroom'] = {
            strenght = 100,
            speed = 500,
            width = 12,
            height = 12,
            hitbox = {
                offsetX = 1,
                offsetY = 15
            },
            dy = -800,
            fall = true,
            explode = true
        }
    }
}
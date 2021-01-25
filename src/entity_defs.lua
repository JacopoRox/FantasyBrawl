--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

-- raw data the define entities
ENTITY_DEFS = {
    ['warrior'] = {
        type = 'warrior',
        x = WINDOW_WIDTH/2,
        y = FLOOR,
        width = 24,
        height = 44,
        health = 400,
        strenght = 120,
        atkspeed = 0.08,
        atkrange = 50,
        atkframe = 5,
        speed = 300,
        jump = 1000,
        atkmove = false,
        scale = 3,
        hurtbox = {
            offsetX = 12,
            offsetY = 22
        },
        offsetY = 7
    },
    ['huntress'] = {
        type = 'huntress',
        x = WINDOW_WIDTH/2,
        y = FLOOR,
        width = 18,
        height = 38,
        health = 250,
        strenght = 60,
        atkspeed = 0.06,
        atkrange = 40,
        atkframe = 4,
        speed = 350,
        jump = 1100,
        atkmove = false,
        ranged = true,
        scale = 3,
        hurtbox = {
            offsetX = 9,
            offsetY = 16
        }
    },
    ['samurai'] = {
        type = 'samurai',
        x = WINDOW_WIDTH/2,
        y = FLOOR,
        width = 24,
        height = 44,
        health = 300,
        strenght = 50,
        atkspeed = 0.05,
        atkrange = 60,
        atkframe = 5,
        speed = 320,
        jump = 1000,
        atkmove = true,
        scale = 3,
        hurtbox = {
            offsetX = 12,
            offsetY = 22
        }
    },
    ['goblin'] = {
        type = 'goblin',
        y = FLOOR,
        width = 20,
        height = 36,
        health = 120,
        strenght = 50,
        atkspeed = 0.1,
        atkrange = 30,
        atkframe = 7,
        speed = 300,
        ranged = true,
        scale = 2,
        hurtbox = {
            offsetX = 10,
            offsetY = 3
        },
        offsetY = 13,
    },
    ['skeleton'] = {
        type = 'skeleton',
        y = FLOOR,
        width = 30,
        height = 52,
        health = 150,
        strenght = 80,
        atkspeed = 0.12,
        atkrange = 50,
        restTime = 0.5,
        aggressive = true,
        atkframe = 7,
        speed = 280,
        scale = 2,
        hurtbox = {
            offsetX = 15,
            offsetY = 19
        },
        offsetY = 13,
    },
    ['mushroom'] = {
        type = 'mushroom',
        y = FLOOR,
        width = 30,
        height = 38,
        health = 500,
        strenght = 70,
        atkspeed = 0.12,
        atkrange = 15,
        ranged = true,
        atkframe = 7,
        speed = 150,
        scale = 3,
        hurtbox = {
            offsetX = 15,
            offsetY = 16
        },
        offsetY = -12,
    },
    ['eye'] = {
        type = 'eye',
        y = FLOOR - 80,
        width = 24,
        height = 20,
        health = 100,
        strenght = 35,
        atkspeed = 0.04,
        atkrange = 10,
        atkmove = true,
        aggressive = true,
        atkframe = 6,
        speed = 300,
        restTime = 1,
        scale = 2,
        hurtbox = {
            offsetX = 12,
            offsetY = 1
        },
        offsetY = 13
    },
    ['fire-wizard'] = {
        type = 'fire-wizard',
        y = FLOOR,
        width = 30,
        height = 44,
        health = 100,
        strenght = 35,
        atkspeed = 0.06,
        atkrange = 40,
        atkmove = true,
        atkframe = 2,
        speed = 250,
        restTime = 0.7,
        scale = 2.5,
        hurtbox = {
            offsetX = 15,
            offsetY = 20
        },
        offsetY = 0
    },
    ['violet-wizard'] = {
        type = 'violet-wizard',
        y = FLOOR,
        width = 30,
        height = 54,
        health = 200,
        strenght = 50,
        atkspeed = 0.15,
        atkrange = 80,
        atkframe = 5,
        speed = 250,
        restTime = 0.5,
        aggressive = true,
        scale = 2.5,
        hurtbox = {
            offsetX = 15,
            offsetY = 27
        },
        offsetY = -37
    },
}
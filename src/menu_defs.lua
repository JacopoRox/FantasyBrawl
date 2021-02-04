--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MENU_DEFS = {
    ['start'] = {
        ['title'] = {
            x = 0,
            y = 100,
            limit = GAME_WIDTH,
            align = 'center',
            string = 'Fantasy Brawl',
            font = gFonts['big-dungeon-font'],
        },
        ['strings'] = {
            [1] = {
                x = 0,
                y = 250,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Play',
                font = gFonts['medium-dungeon-font']
            },
            [2] = {
                x = 0,
                y = 300,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Options',
                font = gFonts['medium-dungeon-font']
            },
            [3] = {
                x = 0,
                y = 350,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Exit',
                font = gFonts['medium-dungeon-font']
            }
        },
        ['color'] = CARMINE,
        ['highlight'] = SIENNA
    },
    ['options'] = {
        ['title'] = {
            x = 0,
            y = 100,
            limit = GAME_WIDTH,
            align = 'center',
            string = 'Menu',
            font = gFonts['great-dungeon-font']
        },
        ['strings'] = {
            [1] = {
                x = 0,
                y = 250,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Volume',
                font = gFonts['medium-dungeon-font'],
            },
            [2] = {
                font = gFonts['medium-dungeon-font'],
                x = 0,
                y = 300,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Commands'
            },
            [3] = {
                font = gFonts['medium-dungeon-font'],
                x = 0,
                y = 350,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Graphics'
            },
            [4] = {
                font = gFonts['medium-dungeon-font'],
                x = 0,
                y = 400,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Back'
            },
        },
        ['color'] = CARMINE,
        ['highlight'] = SIENNA
    },
    ['commands'] = {
        ['title'] = {
            x = 0,
            y = 100,
            limit = GAME_WIDTH,
            align = 'center',
            string = 'Commands Selection',
            font = gFonts['great-dungeon-font'],
        },
        ['strings'] = {
            [1] = {
                x = 0,
                y = 250,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Attack: '..GetKey(STRIKE),
                font = gFonts['medium-dungeon-font'],
            },
            [2] = {
                x = 0,
                y = 300,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Shoot: '..GetKey(RANGED),
                font = gFonts['medium-dungeon-font'],
            },
            [3] = {
                x = 0,
                y = 350,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Jump: '..GetKey(JUMP),
                font = gFonts['medium-dungeon-font']
            },
            [4] = {
                x = 0,
                y = 400,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Move Right: '..GetKey(RIGHT),
                font = gFonts['medium-dungeon-font']
            },
            [5] = {
                x = 0,
                y = 450,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Move Left: '..GetKey(LEFT),
                font = gFonts['medium-dungeon-font'],
            },
        },
        ['color'] = CARMINE,
        ['highlight'] = SIENNA,
        ['selected'] = RED
    }
}
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
                font = gFonts['medium-dungeon-font'],
            },
            [2] = {
                font = gFonts['medium-dungeon-font'],
                x = 0,
                y = 300,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Options'
            },
            [3] = {
                font = gFonts['medium-dungeon-font'],
                x = 0,
                y = 350,
                limit = GAME_WIDTH,
                align = 'center',
                string = 'Exit'
            }
        },
        ['color'] = CARMINE,
        ['selection'] = SIENNA
    },
    ['options'] = {
        ['title'] = {
            x = 0,
            y = 100,
            limit = GAME_WIDTH,
            align = 'center',
            string = 'Menu',
            font = gFonts['big-dungeon-font'],
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
        ['selection'] = SIENNA
    }
}
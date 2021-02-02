--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MENU_DEFS = {
    ['start'] = {
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
    }
}
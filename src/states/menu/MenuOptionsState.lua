--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuOptionsState = Class{__includes = BaseState}

function MenuOptionsState:init(menu)
    self.menu = menu

    self.selection = Selection {
        x = 0,
        y = 250,
        width = GAME_WIDTH,
        height = 200,
        color = CARMINE,
        highlight = SIENNA,
        font = gFonts['medium-dungeon-font'],
        items = {
            {
                text = 'Volume',
                onSelect = function ()  end
            },
            {
                text = 'Commands',
                onSelect = function ()  end
            },
            {
                text = 'Graphics',
                onSelect = function ()  end
            },
            {
                text = 'Back',
                onSelect = function ()  end
            },
        }
    }
end

function MenuOptionsState:update(dt)
    self.selection:update(dt)

    if love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('start')
    end
end

function MenuOptionsState:render()
   self.selection:render()
end
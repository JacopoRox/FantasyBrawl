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
        height = 250,
        color = CARMINE,
        highlight = SIENNA,
        font = gFonts['medium-dungeon-font'],
        items = {
            {
                text = 'Volume',
                onSelect = function () self.menu.stateMachine:change('volume')  end
            },
            {
                text = 'Commands',
                onSelect = function () self.menu.stateMachine:change('commands') end
            },
            {
                text = 'Graphics',
                onSelect = function ()  end
            },
            {
                text = 'Back',
                onSelect = function () self.menu.stateMachine:change('start') end
            },
        }
    }
end

function MenuOptionsState:update(dt)
    self.selection:update(dt)
    
    if love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('start')
    elseif love.keyboard.PressedThisFrame(ENTER) then
        self.selection.items[self.selection.index].onSelect()
    end
end

function MenuOptionsState:render()
    love.graphics.printf({CARMINE, 'Menu'}, gFonts['great-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.selection:render()
end
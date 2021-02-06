--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuStartState = Class{__includes = BaseState}

function MenuStartState:init(menu)
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
                text = 'Play',
                onSelect = function () gStateMachine:change('selection')  end
            },
            {
                text = 'Options',
                onSelect = function () self.menu.stateMachine:change('options') end
            },
            {
                text = 'Exit',
                onSelect = function () love.event.quit() end
            }
        }
    }
end

function MenuStartState:update(dt)
    self.selection:update(dt)

    if love.keyboard.PressedThisFrame(ESC) then
        love.event.quit()
    elseif love.keyboard.PressedThisFrame(ENTER) then
        self.selection.items[self.selection.index].onSelect()
    end
end

function MenuStartState:render()
    love.graphics.printf({CARMINE, 'Fantasy Brawl'}, gFonts['big-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.selection:render()
end
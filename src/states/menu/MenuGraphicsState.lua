--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuGraphicsState = Class{__includes = BaseState}

function MenuGraphicsState:init(menu)
    -- reference to the menu
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
                text = 'Resolution: ',
                onSelect = function ()  end
            }
        }
    }
end

function MenuGraphicsState:update(dt)
    self.selection:update(dt)

    if love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('options')
    end
end

-- return the last pressed key if the key was pressed this frame
function MenuGraphicsState:assignKey()
    local key = (love.keyboard.pressed[LastPressed] and LastPressed)
    if key then return key else return false end
end

function MenuGraphicsState:render()
    love.graphics.printf({CARMINE, 'Menu'}, gFonts['great-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.selection:render()
end
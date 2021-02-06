--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuCommandsState = Class{__includes = BaseState}

function MenuCommandsState:init(menu)
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
                text = 'Attack: ',
                onSelect = function ()  end
            },
            {
                text = 'Shoot: ',
                onSelect = function ()  end
            },
            {
                text = 'Jump: ',
                onSelect = function ()  end
            },
            {
                text = 'Move Right: ',
                onSelect = function ()  end
            },
            {
                text = 'Move Left: ',
                onSelect = function ()  end
            },
            {
                text = 'Reset Default',
                onSelect = function () self:resetDefault() end
            }
        }
    }
end

function MenuCommandsState:update(dt)
    self.selection:update(dt)

    if love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('options')
    elseif love.keyboard.PressedThisFrame(ENTER) then
        self.selection.items[self.selection.index].onSelect()
    end
end

function MenuCommandsState:resetDefault()
    STRIKE = DEFAULT_KEYS['strike']
    self.strings[1].string = 'Attack: '..GetKey(STRIKE)
    RANGED = DEFAULT_KEYS['shoot']
    self.strings[2].string = 'Shoot: '..GetKey(RANGED)
    JUMP = DEFAULT_KEYS['jump']
    self.strings[3].string = 'Jump: '..GetKey(JUMP)
    RIGHT = DEFAULT_KEYS['right']
    self.strings[4].string = 'Move Right: '..GetKey(RIGHT)
    LEFT = DEFAULT_KEYS['left']
    self.strings[5].string = 'Move Left: '..GetKey(LEFT)
end

-- return the last pressed key if the key was pressed this frame
function MenuCommandsState:assignKey()
    local key = (love.keyboard.pressed[LastPressed] and LastPressed)
    if key then return key else return false end
end

function MenuCommandsState:render()
    love.graphics.printf({CARMINE, 'Menu'}, gFonts['great-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.selection:render {
        GetKey(STRIKE),
        GetKey(RANGED),
        GetKey(JUMP),
        GetKey(RIGHT),
        GetKey(LEFT),
    }
end
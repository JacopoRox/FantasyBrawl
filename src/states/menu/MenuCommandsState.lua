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
                -- todo: implement changeble keys
                onSelect = function ()  end
            },
            {
                text = 'Shoot: ',
                -- todo: implement changeble keys
                onSelect = function ()  end
            },
            {
                text = 'Jump: ',
                -- todo: implement changeble keys
                onSelect = function ()  end
            },
            {
                text = 'Move Right: ',
                -- todo: implement changeble keys
                onSelect = function ()  end
            },
            {
                text = 'Move Left: ',
                -- todo: implement changeble keys
                onSelect = function ()  end
            },
            {
                text = 'Reset Default',
                -- todo: implement changeble keys
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

-- reset all keys to default
function MenuCommandsState:resetDefault()
    STRIKE = DEFAULT_KEYS['strike']
    RANGED = DEFAULT_KEYS['shoot']
    JUMP = DEFAULT_KEYS['jump']
    RIGHT = DEFAULT_KEYS['right']
    LEFT = DEFAULT_KEYS['left']
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
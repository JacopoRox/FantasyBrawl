--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

MenuVolumeState = Class{__includes = BaseState}

function MenuVolumeState:init(menu)
    -- reference to the menu
    self.menu = menu

    self.selection = Selection {
        x = 0,
        y = 250,
        width = GAME_WIDTH,
        height = 250,
        align = 'center',
        color = CARMINE,
        highlight = SIENNA,
        font = gFonts['medium-dungeon-font'],
        items = {
            {
                text = 'Volume: '
            }
        }
    }
    self.timer = 0
end

function MenuVolumeState:update(dt)
    self.timer = self.timer + dt

    self.selection:update(dt)

    self:changeVolume(LastPressed)

    if love.keyboard.PressedThisFrame(ESC) then
        self.menu.stateMachine:change('options')
    end
end

function MenuVolumeState:changeVolume(key)
    if love.keyboard.pressed[key] or (love.keyboard.isDown(key) and self.timer > 0.15) then
        if key == 'right' then
            VOLUME = math.min(VOLUME + 0.05, 1)
            love.audio.setVolume(VOLUME)
            self.timer = 0
        elseif key == 'left' then
            VOLUME = math.max(VOLUME - 0.05, 0)
            love.audio.setVolume(VOLUME)
            self.timer = 0
        end
    end
end

function MenuVolumeState:render()
    love.graphics.printf({CARMINE, 'Menu'}, gFonts['great-dungeon-font'], 0, 100, GAME_WIDTH, 'center')
    self.selection:render{VOLUME*100}
end
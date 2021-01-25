--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

SelectionState = Class{__includes = BaseState}

function SelectionState:init()
    self.types = {'warrior', 'huntress', 'samurai'}
    local status = 'idle'

    self.animations = {}
    -- initiate the animations of the characters
    for k, v in pairs(self.types) do
        self.animations[k] = Animation {
            texture = gTextures[v][status],
            frames = gFrames[v][status]
        }
    end

    -- defines selection box
    self.box = Box(WINDOW_WIDTH/4 - 100, WINDOW_HEIGHT/2 - 100, 200, 200)
    self.box.index = 1
end

function SelectionState:enter(background)
    self.background = background
end

function SelectionState:update(dt)
    -- updates the background and the position of the selection box
    self.background:update(dt)
    self:movebox(self.box)
    -- if ENTER is pressed an hero is selected and a Hero object is initiated
    -- the game state is also changed
    if love.keyboard.PressedThisFrame(ENTER) then
        gStateMachine:change('play', {
            player = Hero(ENTITY_DEFS[self.types[self.box.index]]),
            background = self.background
        })
    end
    -- updates the animation of the heroes
    for k, v in pairs(self.animations) do
        v:update(dt)
    end
end

function SelectionState:render()
    -- render the background
    self.background:render()

    local box = self.box
    local anims = self.animations
    -- render the selection box
    love.graphics.setColor(150/225, 0/255, 24/255)
    box:render()
    love.graphics.printf('Press enter to select a hero', gFonts['medium-dungeon-font'],
        0, 100, WINDOW_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1)
    -- render the characters' animations
    for k in pairs(anims) do
        anims[k]:render(k * WINDOW_WIDTH/4, WINDOW_HEIGHT/2, 3, 3)
    end
end

function SelectionState:movebox(box)
    -- move the selection box to the right
    if love.keyboard.PressedThisFrame(RIGHT) then
        box.x = math.min(box.x + WINDOW_WIDTH/4, WINDOW_WIDTH * 3/4 - box.width/2)
        box.index = math.min(box.index + 1, 3)
    end
    -- move the selection box to the left
    if love.keyboard.PressedThisFrame(LEFT) then
        box.x = math.max(box.x - WINDOW_WIDTH/4, WINDOW_WIDTH/4 - box.width/2)
        box.index = math.max(box.index - 1, 1)
    end
end
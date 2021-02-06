--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Selection = Class{}

function Selection:init(def)
    -- holds text and onSelect function
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['medium-dungeon-font']

    self.gapHeight = self.height / #self.items

    self.index = 1

    -- colors used to render the options
    self.color = def.color or BLACK
    self.highlight = def.highlight or WHITE

    -- defines how fast options can be switched, default is 0.2 seconds
    self.timer = 0
    self.interval = def.interval or 0.2
end

function Selection:update(dt)
    -- timer to keep track of time
    self.timer = self.timer + dt
    -- checks input and switch index accordingly resetting timer
    if love.keyboard.PressedThisFrame(DOWN) or (love.keyboard.isDown(DOWN) and self.timer > self.interval) then
        self.index = math.max(1, (self.index + 1) % (#self.items + 1))
        self.timer = 0
    elseif love.keyboard.PressedThisFrame(UP) or (love.keyboard.isDown(UP) and self.timer > self.interval) then
        self.index = self.index - 1
        if self.index == 0 then self.index = #self.items end
        self.timer = 0
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.index then
            love.graphics.printf({self.highlight, self.items[i].text}, self.font, self.x, paddedY, self.width, 'center')
        else
            love.graphics.printf({self.color, self.items[i].text}, self.font, self.x, paddedY, self.width, 'center')
        end
    
        currentY = currentY + self.gapHeight
    end
end
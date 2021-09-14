--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Box = Class{}

function Box:init(x, y, width, height, mode)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    -- optional, default mode is line
    self.mode = mode or 'line'
end

function Box:collides(target)
    -- AABB collision detection
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Box:update(x, y)
    -- updates the position of the box given new x and y
    self.x = x
    self.y = y or self.y
end

function Box:render()
    -- render the box
    love.graphics.rectangle(self.mode, self.x, self.y, self.width, self.height)
end
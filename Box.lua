--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Box = Class{}

function Box:init(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
end

-- AABB collision detection
function Box:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

-- updates the position of the box given new x and y
function Box:update(x, y)
    self.x = x
    self.y = y
end

-- render the box if necessary during development
function Box:render()
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
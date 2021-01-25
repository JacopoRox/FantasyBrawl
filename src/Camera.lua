--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Camera = Class{}

function Camera:init(object)
    -- the object to be fallowed
    self.object = object
    -- we only want to fallow our object in the x
    self.x = WINDOW_WIDTH / 2 - self.object.x
end

function Camera:update()
    -- updates the camera x
    self.x = WINDOW_WIDTH / 2 - self.object.x
end
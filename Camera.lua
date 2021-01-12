Camera = Class{}

function Camera:init(object)
    self.object = object
    self.x = 0
    self.y = 0
end

function Camera:update(dt)
    -- If the object is going right and goes behond the middle of the screen the camera fallows it
    if self.object.dx > 0 and self.object.x > WINDOW_WIDTH/2 - self.x then
        self.x = WINDOW_WIDTH / 2 - self.object.x
    end

    -- Hacks for the camera in order to work on the game (to be removed)
    self.x = WINDOW_WIDTH / 2 - self.object.x
end
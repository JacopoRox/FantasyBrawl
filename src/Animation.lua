--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Animation = Class{}
-- Holds a texture and a collection of frames that switch depending on how much time has passed
function Animation:init(params)
    -- the texture to render
    self.texture = params.texture

    -- quads defining this animation
    self.frames = params.frames or {}

    -- offsets used to render the texture relatively to the center
    self.offsetY = self.texture:getHeight() / 2
    self.offsetX = self.texture:getWidth() / #self.frames / 2

    -- time in seconds each frame takes (1/10 by default)
    self.interval = params.interval or 0.1

    -- stores amount of time that has elapsed
    self.timer = 0
    -- keeps track of how many times this animation was played
    self.timesPlayed = 0
    -- initial frame is set to 1
    self.currentFrame = 1
end

function Animation:getCurrentFrame()
    -- return the current frame of the animation
    return self.frames[self.currentFrame]
end

function Animation:restart()
    -- restart the animation timer and currentFrame
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    -- updates timer using dt
    self.timer = self.timer + dt
    -- if enough time has passed updates currentFrame and reset timer
    if self.timer > self.interval then
        self.timer = 0
        self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
        -- if we've looped back to the beginning, record
        if self.currentFrame == 1 then
            self.timesPlayed = self.timesPlayed + 1
        end
    end
end

function Animation:render(x, y, scaleX, scaleY, box)
    -- render the texture at the currentFrame, using the coordinates of the entity to be rendered
    love.graphics.draw(self.texture, self.frames[self.currentFrame],
        math.floor(x), math.floor(y), 0,
        scaleX, scaleY, self.offsetX, self.offsetY)

    --draws a box of the size of the frame, used during development
    --[[if box then
        love.graphics.rectangle('line', x - self.offsetX, y - self.offsetY, self.texture:getWidth()/#self.frames, self.texture:getHeight())
        love.graphics.line(x - self.offsetX, y - self.offsetY, x - self.offsetX + self.texture:getWidth()/#self.frames, y - self.offsetY + self.texture:getHeight())
        love.graphics.line(x - self.offsetX, y - self.offsetY + self.texture:getHeight(), x - self.offsetX + self.texture:getWidth()/#self.frames, y - self.offsetY)
    end]]
end
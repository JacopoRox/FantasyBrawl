--[[
    Holds a collection of frames that switch depending on how much time has
    passed.
]]

Animation = Class{}

function Animation:init(params)

    self.texture = params.texture

    -- quads defining this animation
    self.frames = params.frames or {}

    self.offsetY = self.texture:getHeight() / 2
    self.offsetX = self.texture:getWidth() / #self.frames / 2

    -- time in seconds each frame takes (1/10 by default)
    self.interval = params.interval or 0.1

    -- stores amount of time that has elapsed
    self.timer = 0

    -- keeps track of how many times this animation was played
    self.timesPlayed = 0

    self.currentFrame = 1
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end

function Animation:restart()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    self.timer = self.timer + dt

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
    love.graphics.draw(self.texture, self.frames[self.currentFrame],
        math.floor(x), math.floor(y), 0,
        scaleX, scaleY, self.offsetX, self.offsetY)

    --draws box, to be removed
    --[[if box then
        love.graphics.rectangle('line', x - self.offsetX, y - self.offsetY, self.texture:getWidth()/#self.frames, self.texture:getHeight())
        love.graphics.line(x - self.offsetX, y - self.offsetY, x - self.offsetX + self.texture:getWidth()/#self.frames, y - self.offsetY + self.texture:getHeight())
        love.graphics.line(x - self.offsetX, y - self.offsetY + self.texture:getHeight(), x - self.offsetX + self.texture:getWidth()/#self.frames, y - self.offsetY)
    end]]
end
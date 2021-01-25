--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Healthbar = Class{}

function Healthbar:init(entity)
    self.entity = entity
    self.width = 70
    self.height = 10
    self.x = entity.x - self.width/2
    -- y is set to be slightly over the head of each entity
    self.y = entity.hurtbox.y - 40
    self.initialHealth = entity.health
end

function Healthbar:update()
    -- updates x and y according to those of the entity
    local entity = self.entity
    self.x = entity.x - self.width/2
    self.y = entity.hurtbox.y - 40
end

function Healthbar:render()
    -- health is equal to the ratio between current and initial health
    local health = self.entity.health / self.initialHealth
    -- draws a red rectagle
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', (self.x), (self.y), self.width, self.height)
    -- draws a green unfilled rectagle
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', (self.x), (self.y), self.width, self.height)
    -- draws a green filled rectagle regulating the width according to the health of the entity
    love.graphics.rectangle('fill', (self.x), (self.y), self.width * health, self.height)
    love.graphics.setColor(1, 1, 1)
end
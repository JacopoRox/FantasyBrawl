Healthbar = Class{}

function Healthbar:init(entity)
    self.entity = entity
    self.width = 70
    self.height = 10
    self.x = entity.x - self.width/2
    self.y = entity.hurtbox.y - 40
    self.initialHealth = entity.health
end

function Healthbar:update()
    local entity = self.entity
    self.x = entity.x - self.width/2
    self.y = entity.hurtbox.y - 40
end

function Healthbar:render()
    local health = self.entity.health / self.initialHealth
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', (self.x), (self.y), self.width, self.height)
    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', (self.x), (self.y), self.width, self.height)
    love.graphics.rectangle('fill', (self.x), (self.y), self.width * health, self.height)
    love.graphics.setColor(1, 1, 1)
end
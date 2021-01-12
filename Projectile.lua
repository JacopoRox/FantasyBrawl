Projectile = Class{}

function Projectile:init(entity)
    local def = GAME_OBJECT_DEFS['projectiles'][entity.type]

    -- same scales of the corresponding entity
    self.scaleX = entity.scaleX
    self.scaleY = entity.scaleY
    -- width and height are multiplied by scaleY because it is always positive
    self.width = def.width * self.scaleY
    self.height = def.height * self.scaleY
    self.box = {
        offsetX = def.hitbox.offsetX or 0,
        offsetY = def.hitbox.offsetY or 0
    }

    self.y = def.y or entity.y
    self.dy = def.dy or 0

    if entity:getDirection() == 'right' then
        -- if the entity is facing right the projectiles gets shot to the right
        self.dx = def.speed
        self.x = entity.hurtbox.x + entity.hurtbox.width
    else
        -- else gets shot to the left
        self.dx = -def.speed
        self.x = entity.hurtbox.x
    end

    -- flags
    self.fall = def.fall or false
    self.explode = def.explode or false
    self.strenght = def.strenght
    self.animation = Animation {
        texture = gTextures[entity.type]['projectile'],
        frames = gFrames[entity.type]['projectile']
    }
    -- hitbox gets adjusted to match animation offset
    self.hitbox = Box(self.x - self.width/2 - self.box.offsetX, self.y - self.box.offsetY, self.width, self.height)
end

function Projectile:update(dt)
    self.animation:update(dt)

    if self.fall then
        self.dy = self.dy + GRAVITY * dt
        self.y = self.y + self.dy * dt
    end
    self.x = self.x + self.dx * dt
    self.hitbox:update(self.x - self.width/2 - self.box.offsetX, self.y - self.box.offsetY)
end

function Projectile:render()
    self.animation:render(self.x, self.y, self.scaleX, self.scaleY)
    --self.hitbox:render()
end
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Hero = Class{__includes = Entity}

-- inherits from entity but initiate its own stateMachine
function Hero:init(def)
    Entity.init(self, def)

    self.stateMachine = StateMachine {
        ['idle'] = function () return HeroIdleState(self) end,
        ['run'] = function () return HeroRunState(self) end,
        ['attack'] = function () return HeroAttackState(self) end,
        ['ranged'] = function () return HeroRangedState(self) end,
        ['fall'] = function () return HeroFallingState(self) end,
        ['jump'] = function () return HeroJumpingState(self) end,
        ['take hit'] = function () return HeroTakeHitState(self) end,
        ['death'] = function () return HeroDeathState(self) end
    }
    self.stateMachine:change('idle')
end

function Hero:updateProjectiles(dt)
    -- updates projectiles and remove them from the table if they hit an enemy
    for i, projectile in ipairs(self.projectiles) do
        projectile:update(dt)
        for k, entity in ipairs(self.level.entities) do
            if entity.hurtbox:collides(projectile.hitbox) then
                entity:damage(projectile.strenght)
                table.remove(self.projectiles, i)
                break
            end
        end
    end
end

function Hero:moveLeft()
    -- checks wheter the player is moving left
    return love.keyboard.isDown(LEFT) and (LastPressed ~= RIGHT or not love.keyboard.isDown(RIGHT))
end

function Hero:moveRight()
    -- checks wheter the player is moving right
    return love.keyboard.isDown(RIGHT) and (LastPressed ~= LEFT or not love.keyboard.isDown(LEFT))
end

function Hero:moveUp()
    -- checks wheter the player is jumping
    return love.keyboard.PressedThisFrame(JUMP) or love.keyboard.isDown(JUMP) or love.keyboard.PressedThisFrame(UP) or love.keyboard.isDown(UP)
end

function Hero:attack()
    -- checks wheter the player attacking
    return love.keyboard.PressedThisFrame(STRIKE)
end

function Hero:shoot()
    -- checks wheter the player is shooting
    return love.keyboard.PressedThisFrame(RANGED) and self.ranged
end

function Hero:update(dt)
    Entity.update(self, dt)
end

function Hero:render()
    Entity.render(self)
end
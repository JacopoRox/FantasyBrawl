Hero = Class{__includes = Entity}

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

function Hero:update(dt)
    Entity.update(self, dt)
end

function Hero:render()
    Entity.render(self)
end
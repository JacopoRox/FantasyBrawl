--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

Class = require 'lib/class'
push = require 'lib/push'

require 'src/constants'

require 'src/Entity'
require 'src/Hero'
require 'src/Projectile'
require 'src/Camera'
require 'src/Level'
require 'src/Background'
require 'src/Animation'
require 'src/Util'
require 'src/Box'
require 'src/Healthbar'
require 'src/StateMachine'

require 'src/entity_defs'
require 'src/object_defs'

require 'src/states/BaseState'

require 'src/states/background/BackgroundPlayState'
require 'src/states/background/BackgroundSelectionState'

require 'src/states/game/StartState'
require 'src/states/game/SelectionState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'
require 'src/states/game/PauseState'
require 'src/states/game/MenuState'

require 'src/states/entities/hero/HeroAttackState'
require 'src/states/entities/hero/HeroRangedState'
require 'src/states/entities/hero/HeroDeathState'
require 'src/states/entities/hero/HeroFallingState'
require 'src/states/entities/hero/HeroIdleState'
require 'src/states/entities/hero/HeroJumpingState'
require 'src/states/entities/hero/HeroRunState'
require 'src/states/entities/hero/HeroTakeHitState'

require 'src/states/entities/EntityIdleState'
require 'src/states/entities/EntityAttackState'
require 'src/states/entities/EntityRangedState'
require 'src/states/entities/EntityRunState'
require 'src/states/entities/EntityDeathState'
require 'src/states/entities/EntityTakeHitState'

-- store in memory all the files the game needs
gTextures = {
    ['warrior'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/warrior/sprites/Attack1.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/warrior/sprites/Attack3.png'),
        ['death'] = love.graphics.newImage('spritesheets/warrior/sprites/Death.png'),
        ['fall'] = love.graphics.newImage('spritesheets/warrior/sprites/Fall.png'),
        ['idle'] = love.graphics.newImage('spritesheets/warrior/sprites/Idle.png'),
        ['jump'] = love.graphics.newImage('spritesheets/warrior/sprites/Jump.png'),
        ['run'] = love.graphics.newImage('spritesheets/warrior/sprites/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/warrior/sprites/Take Hit.png')
    },
    ['huntress'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/huntress/sprites/Attack1.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/huntress/sprites/Attack2.png'),
        ['ranged'] = love.graphics.newImage('spritesheets/huntress/sprites/Attack3.png'),
        ['death'] = love.graphics.newImage('spritesheets/huntress/sprites/Death.png'),
        ['fall'] = love.graphics.newImage('spritesheets/huntress/sprites/Fall.png'),
        ['idle'] = love.graphics.newImage('spritesheets/huntress/sprites/Idle.png'),
        ['jump'] = love.graphics.newImage('spritesheets/huntress/sprites/Jump.png'),
        ['run'] = love.graphics.newImage('spritesheets/huntress/sprites/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/huntress/sprites/Take Hit.png'),
        ['projectile'] = love.graphics.newImage('spritesheets/huntress/sprites/Spear move.png')
    },
    ['samurai'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/samurai/sprites/Attack1.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/samurai/sprites/Attack2.png'),
        ['death'] = love.graphics.newImage('spritesheets/samurai/sprites/Death.png'),
        ['fall'] = love.graphics.newImage('spritesheets/samurai/sprites/Fall.png'),
        ['idle'] = love.graphics.newImage('spritesheets/samurai/sprites/Idle.png'),
        ['jump'] = love.graphics.newImage('spritesheets/samurai/sprites/Jump.png'),
        ['run'] = love.graphics.newImage('spritesheets/samurai/sprites/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/samurai/sprites/Take Hit.png')
    },
    ['violet-wizard'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Attack1.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Attack2.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Death.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Idle.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/evil wizard 2/Take Hit.png')
    },
    ['fire-wizard'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Attack.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Attack.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Death.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Idle.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Move.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/evil wizard/Take Hit.png')
    },
    ['goblin'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/goblin/Attack.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/goblin/Attack2.png'),
        ['ranged'] = love.graphics.newImage('spritesheets/enemies/goblin/Attack3.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/goblin/Idle.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/goblin/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/goblin/Take Hit.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/goblin/Death.png'),
        ['projectile'] = love.graphics.newImage('spritesheets/enemies/goblin/Bomb_sprite.png')
    },
    ['skeleton'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/skeleton/Attack.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/skeleton/Attack2.png'),
        ['ranged'] = love.graphics.newImage('spritesheets/enemies/skeleton/Attack3.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/skeleton/Idle.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/skeleton/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/skeleton/Take Hit.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/skeleton/Death.png'),
        ['projectile'] = love.graphics.newImage('spritesheets/enemies/skeleton/Sword_sprite.png')
    },
    ['mushroom'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/mushroom/Attack.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/mushroom/Attack2.png'),
        ['ranged'] = love.graphics.newImage('spritesheets/enemies/mushroom/Attack3.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/mushroom/Idle.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/mushroom/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/mushroom/Take Hit.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/mushroom/Death.png'),
        ['projectile'] = love.graphics.newImage('spritesheets/enemies/mushroom/Projectile_sprite.png')
    },
    ['eye'] = {
        ['attack1'] = love.graphics.newImage('spritesheets/enemies/flying eye/Attack.png'),
        ['attack2'] = love.graphics.newImage('spritesheets/enemies/flying eye/Attack2.png'),
        ['idle'] = love.graphics.newImage('spritesheets/enemies/flying eye/Attack3.png'),
        ['run'] = love.graphics.newImage('spritesheets/enemies/flying eye/Run.png'),
        ['take hit'] = love.graphics.newImage('spritesheets/enemies/flying eye/Take Hit.png'),
        ['death'] = love.graphics.newImage('spritesheets/enemies/flying eye/Death.png')
    },
    ['forest'] = {
        [1] = love.graphics.newImage('spritesheets/forest/10_Sky.png'),
        [2] = love.graphics.newImage('spritesheets/forest/09_Forest.png'),
        [3] = love.graphics.newImage('spritesheets/forest/08_Forest.png'),
        [4] = love.graphics.newImage('spritesheets/forest/07_Forest.png'),
        [5] = love.graphics.newImage('spritesheets/forest/06_Forest.png'),
        [6] = love.graphics.newImage('spritesheets/forest/05_Particles.png'),
        [7] = love.graphics.newImage('spritesheets/forest/04_Forest.png'),
        [8] = love.graphics.newImage('spritesheets/forest/03_Particles.png'),
        [9] = love.graphics.newImage('spritesheets/forest/02_Bushes.png'),
        [10] = love.graphics.newImage('spritesheets/forest/01_Mist.png')
    }
}

gFrames = {
    ['warrior'] = {
        ['attack1'] = GenerateQuads(gTextures['warrior']['attack1'], 162, 162),
        ['attack2'] = GenerateQuads(gTextures['warrior']['attack2'], 162, 162),
        ['death'] = GenerateQuads(gTextures['warrior']['death'], 162, 162),
        ['fall'] = GenerateQuads(gTextures['warrior']['fall'], 162, 162),
        ['idle'] = GenerateQuads(gTextures['warrior']['idle'], 162, 162),
        ['jump'] = GenerateQuads(gTextures['warrior']['jump'], 162, 162),
        ['run'] = GenerateQuads(gTextures['warrior']['run'], 162, 162),
        ['take hit'] = GenerateQuads(gTextures['warrior']['take hit'], 162, 162)
    },
    ['huntress'] = {
        ['attack1'] = GenerateQuads(gTextures['huntress']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['huntress']['attack2'], 150, 150),
        ['ranged'] = GenerateQuads(gTextures['huntress']['ranged'], 150, 150),
        ['death'] = GenerateQuads(gTextures['huntress']['death'], 150, 150),
        ['fall'] = GenerateQuads(gTextures['huntress']['fall'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['huntress']['idle'], 150, 150),
        ['jump'] = GenerateQuads(gTextures['huntress']['jump'], 150, 150),
        ['run'] = GenerateQuads(gTextures['huntress']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['huntress']['take hit'], 150, 150),
        ['projectile'] = GenerateQuads(gTextures['huntress']['projectile'], 60, 20)
    },
    ['samurai'] = {
        ['attack1'] = GenerateQuads(gTextures['samurai']['attack1'], 200, 200),
        ['attack2'] = GenerateQuads(gTextures['samurai']['attack2'], 200, 200),
        ['death'] = GenerateQuads(gTextures['samurai']['death'], 200, 200),
        ['fall'] = GenerateQuads(gTextures['samurai']['fall'], 200, 200),
        ['idle'] = GenerateQuads(gTextures['samurai']['idle'], 200, 200),
        ['jump'] = GenerateQuads(gTextures['samurai']['jump'], 200, 200),
        ['run'] = GenerateQuads(gTextures['samurai']['run'], 200, 200),
        ['take hit'] = GenerateQuads(gTextures['samurai']['take hit'], 200, 200)
    },
    ['goblin'] = {
        ['attack1'] = GenerateQuads(gTextures['goblin']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['goblin']['attack2'], 150, 150),
        ['ranged'] = GenerateQuads(gTextures['goblin']['ranged'], 150, 150),
        ['death'] = GenerateQuads(gTextures['goblin']['death'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['goblin']['idle'], 150, 150),
        ['run'] = GenerateQuads(gTextures['goblin']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['goblin']['take hit'], 150, 150),
        ['projectile'] = GenerateQuads(gTextures['goblin']['projectile'], 100, 100)
    },
    ['skeleton'] = {
        ['attack1'] = GenerateQuads(gTextures['skeleton']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['skeleton']['attack2'], 150, 150),
        ['ranged'] = GenerateQuads(gTextures['skeleton']['ranged'], 150, 150),
        ['death'] = GenerateQuads(gTextures['skeleton']['death'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['skeleton']['idle'], 150, 150),
        ['run'] = GenerateQuads(gTextures['skeleton']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['skeleton']['take hit'], 150, 150),
        ['projectile'] = GenerateQuads(gTextures['skeleton']['projectile'], 92, 92)
    },
    ['mushroom'] = {
        ['attack1'] = GenerateQuads(gTextures['mushroom']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['mushroom']['attack2'], 150, 150),
        ['ranged'] = GenerateQuads(gTextures['mushroom']['ranged'], 150, 150),
        ['death'] = GenerateQuads(gTextures['mushroom']['death'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['mushroom']['idle'], 150, 150),
        ['run'] = GenerateQuads(gTextures['mushroom']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['mushroom']['take hit'], 150, 150),
        ['projectile'] = GenerateQuads(gTextures['mushroom']['projectile'], 50, 50)
    },
    ['eye'] = {
        ['attack1'] = GenerateQuads(gTextures['eye']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['eye']['attack2'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['eye']['idle'], 150, 150),
        ['death'] = GenerateQuads(gTextures['eye']['death'], 150, 150),
        ['run'] = GenerateQuads(gTextures['eye']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['eye']['take hit'], 150, 150)
    },
    ['fire-wizard'] = {
        ['attack1'] = GenerateQuads(gTextures['fire-wizard']['attack1'], 150, 150),
        ['attack2'] = GenerateQuads(gTextures['fire-wizard']['attack2'], 150, 150),
        ['idle'] = GenerateQuads(gTextures['fire-wizard']['idle'], 150, 150),
        ['death'] = GenerateQuads(gTextures['fire-wizard']['death'], 150, 150),
        ['run'] = GenerateQuads(gTextures['fire-wizard']['run'], 150, 150),
        ['take hit'] = GenerateQuads(gTextures['fire-wizard']['take hit'], 150, 150)
    },
    ['violet-wizard'] = {
        ['attack1'] = GenerateQuads(gTextures['violet-wizard']['attack1'], 250, 250),
        ['attack2'] = GenerateQuads(gTextures['violet-wizard']['attack2'], 250, 250),
        ['idle'] = GenerateQuads(gTextures['violet-wizard']['idle'], 250, 250),
        ['death'] = GenerateQuads(gTextures['violet-wizard']['death'], 250, 250),
        ['run'] = GenerateQuads(gTextures['violet-wizard']['run'], 250, 250),
        ['take hit'] = GenerateQuads(gTextures['violet-wizard']['take hit'], 250, 250)
    }
}

gFonts = {
    ['big-half-elven'] = love.graphics.newFont('fonts/halfelven.ttf', 72),
    ['medium-half-elven'] = love.graphics.newFont('fonts/halfelven.ttf', 38),
    ['big-dungeon-font'] = love.graphics.newFont('fonts/DungeonFont.ttf', 90),
    ['medium-dungeon-font'] = love.graphics.newFont('fonts/DungeonFont.ttf', 50),
    ['small-dungeon-font'] = love.graphics.newFont('fonts/DungeonFont.ttf', 38),
    ['smaller-dungeon-font'] = love.graphics.newFont('fonts/DungeonFont.ttf', 30)
}

gShaders = {
    ['white'] = love.graphics.newShader[[
        vec4 effect(vec4 color, Image texture, vec2 textureCoords, vec2 screenCoords){
            return vec4(1, 1, 1, Texel(texture, textureCoords).a) * color;
        }
        ]]
}

gSounds = {
    ['background'] = love.audio.newSource('music/DizzySpells.mp3', 'stream')
}
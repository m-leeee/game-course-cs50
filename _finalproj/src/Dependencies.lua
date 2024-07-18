Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Animation'
require 'src/Constants'
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/GameOverState'
require 'src/entity_defs'

require 'src/Util'

require 'src/Entity'
require 'src/Player'

require 'src/states/entity/EntityIdleState'
require 'src/states/entity/player/PlayerDefaultState'

require 'src/PlayerBullet'
require 'src/Sandbox'
require 'src/Stage'
require 'src/Stage1'
require 'src/Boss'
require 'src/bosses/Shiba'

require 'src/AOE'

gTextures = {
    ['player'] = love.graphics.newImage('graphics/player.png'),
    ['shiba'] = love.graphics.newImage('graphics/shib.png')
}

gFrames = {
    ['player'] = GenerateQuads(gTextures['player'], 256, 256),
    ['shiba'] = GenerateQuads(gTextures['shiba'], 256, 256)
}



gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}
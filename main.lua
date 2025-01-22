local Push = require 'libs/push'

local Camera = require 'modules/camera'

local Game = require 'modules/game'
local Map = require 'modules/map'
local Player = require 'modules/player'

function love.load()
  Camera:load()
  Game:load()
  Map:load()
  Map:setupPhysics(Game.world)
  Player:load(Map.centerX, Map.centerY, Game.world)
end

function love.update(dt)
  Game.world:update(dt)
  Player:update(dt)
  Camera:update(Player, Game.virtualDimensions, Map.bounds)
end

function love.draw()
  Push:start()
    Camera.cam:attach(0, 0, Game.virtualWidth, Game.virtualHeight)
      Map:draw()
      Player:draw()
    Camera.cam:detach()
  Push:finish()
end

function love.resize(w, h)
	Push:resize(w, h)
end
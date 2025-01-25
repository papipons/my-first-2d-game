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
  Game:update(dt)
  Player:update(dt)
  Camera:update(Player, Game.virtualDimensions, Map.bounds)
end

function love.draw()
  Game:startPush()
    Camera.cam:attach(0, 0, Game.virtualWidth, Game.virtualHeight)
      Map:drawStatic()
      Map:setupEdge(Game.world)
      Player:draw()
    Camera.cam:detach()
  Game:finishPush()
end

function love.resize(w, h)
  Game:resizePush(w, h)
end
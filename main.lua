local Camera = require 'modules/camera'

local Game = require 'modules/game'
local Player = require 'modules/player'

function love.load()
  Camera:load()
  Game:load()
  Player:load(Game.currentMap.centerX, Game.currentMap.centerY, Game.world)
end

function love.update(dt)
  Game:update(dt)
  Player:update(dt)
  Camera:update(Player, Game.virtualDimensions, Game.currentMap.bounds)
end

function love.draw()
  Game:startPush()

  Camera.cam:attach(0, 0, Game.virtualWidth, Game.virtualHeight)
    Game.currentMap:draw()
    Player:draw()
  Camera.cam:detach()

  Game:finishPush()
end

function love.resize(w, h)
  Game:resizePush(w, h)
end
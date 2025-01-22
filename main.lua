local Push = require 'libs/push'

local MathHelper = require 'libs/helpers/math'
local CameraManager = require 'modules/camera'

local Game = require 'modules/game'
local Map = require 'modules/map'
local Player = require 'modules/player'

function love.load()
  Game:load()
  Map:load()
  CameraManager:load()
  Player:load(Map.centerX, Map.centerY, Game.world)
end

function love.update(dt)
  Player:update(dt)

  Player.x = MathHelper.Clamp(Player.x, Player.radius, Map.width - Player.radius)
  Player.y = MathHelper.Clamp(Player.y, Player.radius, Map.height - Player.radius)

  CameraManager:update(Player, Game.virtualWidth, Game.virtualHeight, Map.width, Map.height)
end

function love.draw()
  Push:start()
    CameraManager.cam:attach(0, 0, Game.virtualWidth, Game.virtualHeight)
        Map:draw()
        Player:draw()
      CameraManager.cam:detach()
  Push:finish()
end

-- Handles screen resize
function love.resize(w, h)
	Push:resize(w, h)
end
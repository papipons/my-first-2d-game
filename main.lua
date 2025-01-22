local Push = require 'libs/push'
local MathHelper = require 'libs/helpers/math'
local Player = require 'modules/player'
local Map = require 'modules/map'
local CameraManager = require 'modules/camera'
local CoreConfig = require 'modules/coreConfig'

function love.load()
  CoreConfig:load()
  Map:load()
  CameraManager:load()
  Player:load(Map.centerX, Map.centerY)
end

function love.update(dt)
  Player:update(dt)

  Player.x = MathHelper.Clamp(Player.x, Player.radius, Map.width - Player.radius)
  Player.y = MathHelper.Clamp(Player.y, Player.radius, Map.height - Player.radius)

  CameraManager:update(Player, Map.width, Map.height)
end

function love.draw()
  Push:start()
    CameraManager.cam:attach(0, 0, CoreConfig.GAME_WIDTH, CoreConfig.GAME_HEIGHT)
        Map:draw()
        Player:draw()
      CameraManager.cam:detach()
  Push:finish()
end

-- Handles screen resize
function love.resize(w, h)
	Push:resize(w, h)
end
local modCamera = require 'modules/camera'
local modPlayer = require 'modules/player'
local modGame = require 'modules/game'

local camera = modCamera:New()
local game = modGame:New()
local player = modPlayer:New()

function love.load()
  camera:load()
  game:load()
  player:load(game.currentMap.centerX, game.currentMap.centerY, game.world)
end

function love.update(dt)
  game:update(dt)
  player:update(dt)
  camera:update(player, game.virtualDimensions, game.currentMap.bounds)
end

function love.draw()
  game:startPush()
  camera.cam:attach(0, 0, game.vWidth, game.vHeight)

  game.currentMap:draw()

  local drawables = {player, unpack(game.currentMap.decors)}
  table.sort(drawables, function(a, b) return a.y < b.y end)

  for _, drawable in ipairs(drawables) do
    drawable:draw()
  end

  camera.cam:detach()
  game:finishPush()
end

function love.resize(w, h)
  game:resizePush(w, h)
end

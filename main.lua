local modCamera = require 'modules/camera'
local modPlayer = require 'modules/player'

local camera = modCamera:New()
local Game = require 'modules/game'
local player = modPlayer:New()

function love.load()
  camera:load()
  Game:load()
  player:load(Game.currentMap.centerX, Game.currentMap.centerY, Game.world)
end

function love.update(dt)
  Game:update(dt)
  player:update(dt)
  camera:update(player, Game.virtualDimensions, Game.currentMap.bounds)
end

function love.draw()
  Game:startPush()

  camera.cam:attach(0, 0, Game.vWidth, Game.vHeight)
    Game.currentMap:draw()

    local drawables = {player}
    for _, decor in ipairs(Game.currentMap.decors) do
      table.insert(drawables, decor)
    end

    table.sort(drawables, function(a, b) return a.y < b.y end)
    for _, drawable in ipairs(drawables) do
      drawable:draw()
    end
  camera.cam:detach()

  Game:finishPush()
end

function love.resize(w, h)
  Game:resizePush(w, h)
end
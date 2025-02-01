local modCamera = require 'modules/camera'

local camera = modCamera:New()
local Game = require 'modules/game'
local Player = require 'modules/player'

function love.load()
  camera:load()
  Game:load()
  Player:load(Game.currentMap.centerX, Game.currentMap.centerY, Game.world)
end

function love.update(dt)
  Game:update(dt)
  Player:update(dt)
  camera:update(Player, Game.virtualDimensions, Game.currentMap.bounds)
end

function love.draw()
  Game:startPush()

  camera.cam:attach(0, 0, Game.vWidth, Game.vHeight)
    Game.currentMap:draw()

    local drawables = {Player}
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
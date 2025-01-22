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
      -- drawOutlines()
    Camera.cam:detach()
  Push:finish()
end

function love.resize(w, h)
	Push:resize(w, h)
end

function drawOutlines()
  love.graphics.setColor(1, 1, 1)

  -- Player
  local points = {Player.body:getWorldPoints(Player.shape:getPoints())}
  love.graphics.polygon("line", points)

  -- Walls
  if (Map.walls ~= nil) then
    for _, wall in ipairs(Map.walls) do
      if (wall.shapeType == "ellipse") then
        love.graphics.circle('line', wall.x, wall.y, wall.radius)
      elseif (wall.shapeType == "polygon") then
        love.graphics.polygon("line", wall.body:getWorldPoints(wall.shape:getPoints()))
      elseif (wall.shapeType == "rectangle") then
        love.graphics.rectangle('line', wall.x, wall.y, wall.width, wall.height)
      end
    end
  end
  love.graphics.setColor(1, 1, 1)
end
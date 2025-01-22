local Sti = require 'libs/sti'

local Map = {}

function Map:load()
  self.sti = Sti('assets/maps/map0.lua')
  self.width = self.sti.width * self.sti.tilewidth
  self.height = self.sti.height * self.sti.tileheight
  self.centerX = self.width / 2
  self.centerY = self.height / 2
  self.bounds = {
    width = self.width,
    height = self.height
  }
  self.walls = {}
end

function Map:setupPhysics(world)
  self:setupEdge(world)
  self:setupWalls(world)
end

function Map:setupEdge(world)
  local vertices = {
    0, 0,
    self.width, 0,
    self.width, self.height,
    0, self.height
  }

  local mapBoundary = love.physics.newBody(world, 0, 0, "static")
  local mapShape = love.physics.newChainShape(true, unpack(vertices))

  love.physics.newFixture(mapBoundary, mapShape)
end

function Map:setupWalls(world)
  local wallsLayer = self.sti.layers["walls"]
  if not wallsLayer then return end

  for _, object in pairs(wallsLayer.objects) do
    if object.shape == "ellipse" then
      createEllipseWall(object, world)
    elseif object.shape == "polygon" then
      createPolygonWall(object)
    elseif object.shape == "rectangle" then
      createRectangleWall(object, world)
    end
  end
end

function Map:draw()
  self.sti:drawLayer(self.sti.layers["ground"])
  self.sti:drawLayer(self.sti.layers["trees2"])
  self.sti:drawLayer(self.sti.layers["trees1"])
  self.sti:drawLayer(self.sti.layers["trees0"])
  self.sti:drawLayer(self.sti.layers["bridges"])
end

function createEllipseWall(object, world)
  local wall = {}
  wall.shapeType = object.shape
  wall.x = object.x + object.width / 2
  wall.y = object.y + object.height / 2
  wall.radius = object.width / 2
  wall.body = love.physics.newBody(world, wall.x, wall.y, "static")
  wall.shape = love.physics.newCircleShape(wall.radius)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)

  table.insert(Map.walls, wall)
end

function createPolygonWall(object)
end

function createRectangleWall(object, world)
  local wall = {}
  wall.shapeType = object.shape
  wall.x = object.x
  wall.y = object.y
  wall.width = object.width
  wall.height = object.height

  local bodyX = object.x + object.width / 2
  local bodyY = object.y + object.height / 2
  wall.body = love.physics.newBody(world, bodyX, bodyY, "static")
  wall.body:setFixedRotation(true)

  wall.shape = love.physics.newRectangleShape(object.width, object.height)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)

  table.insert(Map.walls, wall)
end

return Map

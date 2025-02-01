local modDecor = require 'modules/decor'

local PhysicsHelper = require 'libs/helpers/physicsHelper'

local Map = {}

function Map:New(sti)
  local map = setmetatable({}, { __index = Map })
  local width = sti.width * sti.tilewidth
  local height = sti.height * sti.tileheight

  map.sti = sti
  map.width = width
  map.height = height
  map.centerX = width / 2
  map.centerY = height / 2
  map.bounds = {
    width = width,
    height = height
  }
  map.decors = {}

  return map
end

function Map:load(world)
  self:setupPhysics(world)
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
  local bridgesLayer = self.sti.layers["walls.bridges"]
  PhysicsHelper.createWall(bridgesLayer, world)

  local stumpsLayer = self.sti.layers["walls.stumps"]
  PhysicsHelper.createWall(stumpsLayer, world)

  self:setupNamedDecors(world)
end

function Map:setupNamedDecors(world)
  local othersLayer = self.sti.layers["walls.others"]
  for _, object in ipairs(othersLayer.objects) do
    -- Look for the scarecrow ellipse object
    if object.name == "scarecrow" then
      local decor = modDecor:New(
        love.graphics.newImage('assets/sprites/scarecrow.png'),
        PhysicsHelper.createEllipseWall(object, world)
      )

      table.insert(self.decors, decor)
    end

    if object.name == "scarecrow2" then
      local decor = modDecor:New(
        love.graphics.newImage('assets/sprites/scarecrow.png'),
        PhysicsHelper.createEllipseWall(object, world)
      )

      table.insert(self.decors, decor)
    end
  end
end

function Map:draw()
  self.sti:drawLayer(self.sti.layers["terrain.grass"])
  self.sti:drawLayer(self.sti.layers["decors.bridges"])
  self.sti:drawLayer(self.sti.layers["decors.stumps"])
end

return Map

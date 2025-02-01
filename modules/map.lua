local Sti = require 'libs/sti'

local PhysicsHelper = require 'libs/helpers/physicsHelper'
local Decor = require 'modules/decor'

local Map = {}

function Map:load(world)
  self.sti = Sti('assets/maps/map0.lua')

  self.width = self.sti.width * self.sti.tilewidth
  self.height = self.sti.height * self.sti.tileheight
  self.centerX = self.width / 2
  self.centerY = self.height / 2
  self.bounds = {
    width = self.width,
    height = self.height
  }

  self.decors = {}

  Map:setupPhysics(world)
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

  Map:setupNamedDecors(world)
end

function Map:setupNamedDecors(world)
  local othersLayer = self.sti.layers["walls.others"]
  for _, object in ipairs(othersLayer.objects) do
    -- Look for the scarecrow ellipse object
    if object.name == "scarecrow" then
      local decor = Decor:New(
        love.graphics.newImage('assets/sprites/scarecrow.png'),
        PhysicsHelper.createEllipseWall(object, world)
      )

      table.insert(self.decors, decor)
    end

    if object.name == "scarecrow2" then
      local decor = Decor:New(
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

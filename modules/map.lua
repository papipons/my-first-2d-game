local Sti = require 'libs/sti'

local PhysicsHelper = require 'libs/helpers/physicsHelper'

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
  self.depthDrawables = {}

  self:setupDepthDrawables()
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
      local wall = PhysicsHelper.createEllipseWall(object, world)
      table.insert(self.walls, wall)
    elseif object.shape == "polygon" then
      local wall = PhysicsHelper.createPolygonWall(object, world)
      table.insert(self.walls, wall)
    elseif object.shape == "rectangle" then
      local wall = PhysicsHelper.createRectangleWall(object, world)
      table.insert(self.walls, wall)
    end
  end
end

function Map:setupDepthDrawables()
  local layers = {"trees.trees3", "trees.trees2", "trees.trees1"}
  for _, layerName in pairs(layers) do
    local data = self.sti.layers[layerName].data
    for y, row in pairs(data) do
      for x, tile in pairs(row) do
        if tile then
          local tileset = self.sti.tilesets[tile.tileset]
          local tileWidth = tileset.tilewidth
          local tileHeight = tileset.tileheight
          local xPos = (x - 1) * tileWidth
          local yPos = (y - 1) * tileHeight
  
          table.insert(self.depthDrawables, {
            x = xPos,
            y = yPos,
            tileset = tileset,
            quad = tile.quad
          })
        end
      end
    end
  end
end

function Map:drawStatic()
  self.sti:drawLayer(self.sti.layers["ground"])
  self.sti:drawLayer(self.sti.layers["stumps"])
  self.sti:drawLayer(self.sti.layers["bridges"])
end

function Map:drawDepthDrawables()
  for _, drawable in pairs(self.depthDrawables) do
    love.graphics.draw(drawable.tileset.image, drawable.quad, drawable.x, drawable.y)
  end
end

return Map

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
end

function Map:setupPhysics(world)
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

function Map:draw()
  self.sti:drawLayer(self.sti.layers["ground"])
  self.sti:drawLayer(self.sti.layers["edges"])
  self.sti:drawLayer(self.sti.layers["trees2"])
  self.sti:drawLayer(self.sti.layers["trees1"])
  self.sti:drawLayer(self.sti.layers["trees0"])
  self.sti:drawLayer(self.sti.layers["bridges"])
end

return Map

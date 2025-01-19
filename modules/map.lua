local Sti = require 'libs/sti'

local Map = {}

function Map:load()
  self.sti = Sti('assets/maps/map0.lua')
  self.width = self.sti.width * self.sti.tilewidth
  self.height = self.sti.height * self.sti.tileheight
  self.centerX = self.width / 2
  self.centerY = self.height / 2
end

function Map:draw()
  self.sti:drawLayer(self.sti.layers["ground"])
  self.sti:drawLayer(self.sti.layers["edges"])
end

return Map

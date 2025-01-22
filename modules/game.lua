local Push = require 'libs/push'

local Game = {
  virtualWidth = 640,
  virtualHeight = 360
}

function Game:load()
  self.virtualDimensions = {
    width = self.virtualWidth,
    height = self.virtualHeight
  }

  -- Setup window
  local windowWidth, windowHeight = love.window.getDesktopDimensions()

  self.windowWidth = windowWidth * 0.7
  self.windowHeight = windowHeight * 0.7

  love.graphics.setDefaultFilter('nearest', 'nearest')

  Push:setupScreen(
    self.virtualWidth,
    self.virtualHeight,
    self.windowWidth,
    self.windowHeight,
    { fullscreen = false, resizable = true }
  )

  -- Setup world
  self.world = love.physics.newWorld(0, 0, true)
end

return Game
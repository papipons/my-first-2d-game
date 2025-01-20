local Push = require 'libs/push'

local W_WIDTH, W_HEIGHT = love.window.getDesktopDimensions()

local CoreConfig = {
  GAME_WIDTH = 640,
  GAME_HEIGHT = 360,
  WINDOW_WIDTH = W_WIDTH * 0.7,
  WINDOW_HEIGHT = W_HEIGHT * 0.7
}

function CoreConfig:load()
  love.graphics.setDefaultFilter('nearest', 'nearest')

  Push:setupScreen(
    self.GAME_WIDTH, 
    self.GAME_HEIGHT, 
    self.WINDOW_WIDTH, 
    self.WINDOW_HEIGHT, 
    { fullscreen = false, resizable = true }
)
end

return CoreConfig
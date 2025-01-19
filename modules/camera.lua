local Camera = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local CameraManager = {
  screen = {
    width = love.graphics.getWidth(),
    height = love.graphics.getHeight()
  }
}

function CameraManager:load()
  self.cam = Camera()
end

function CameraManager:update(target, mapWidth, mapHeight)
  self.cam:lookAt(target.x, target.y)

  self.cam.x = MathHelper.Clamp(self.cam.x, self.screen.width/2, mapWidth - self.screen.width/2)
  self.cam.y = MathHelper.Clamp(self.cam.y, self.screen.height/2, mapHeight - self.screen.height/2)
end

return CameraManager

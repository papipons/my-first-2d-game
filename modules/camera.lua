local Camera = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local CameraManager = {}

function CameraManager:load()
  self.cam = Camera()
end

function CameraManager:update(target, mapWidth, mapHeight)
  self.cam:lookAt(target.x, target.y)

  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()
  self.cam.x = MathHelper.Clamp(self.cam.x, width / 2, mapWidth - width / 2)
  self.cam.y = MathHelper.Clamp(self.cam.y, height / 2, mapHeight - height / 2)
end

return CameraManager

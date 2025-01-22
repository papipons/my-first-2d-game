local Camera = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local CameraManager = {}

function CameraManager:load()
  self.cam = Camera()
end

function CameraManager:update(target, virtualWidth, virtualHeight, mapWidth, mapHeight)
  self.cam:lookAt(target.x, target.y)
  self.cam.x = MathHelper.Clamp(self.cam.x, virtualWidth / 2, mapWidth - virtualWidth / 2)
  self.cam.y = MathHelper.Clamp(self.cam.y, virtualHeight / 2, mapHeight - virtualHeight / 2)
end

return CameraManager

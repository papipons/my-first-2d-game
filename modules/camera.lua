local Camera = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local CameraManager = {}

function CameraManager:load()
  self.cam = Camera()
end

function CameraManager:update(target, virtualDimensions, bounds)
  self.cam:lookAt(target.x, target.y)
  self.cam.x = MathHelper.Clamp(self.cam.x, virtualDimensions.width / 2, bounds.width - virtualDimensions.width / 2)
  self.cam.y = MathHelper.Clamp(self.cam.y, virtualDimensions.height / 2, bounds.height - virtualDimensions.height / 2)
end

return CameraManager

local CameraLib = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local Camera = {}

function Camera:load()
  self.cam = CameraLib()
end

function Camera:update(target, vDimensions, bounds)
  self.cam:lookAt(target.x, target.y)
  self.cam.x = MathHelper.Clamp(self.cam.x, vDimensions.width / 2, bounds.width - vDimensions.width / 2)
  self.cam.y = MathHelper.Clamp(self.cam.y, vDimensions.height / 2, bounds.height - vDimensions.height / 2)
end

return Camera

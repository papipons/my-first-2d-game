local CameraLib = require 'libs/camera'
local MathHelper = require 'libs/helpers/math'

local Camera = {}

function Camera:New()
  return setmetatable({}, { __index = self })
end

function Camera:load()
  self.cam = CameraLib()
end

function Camera:update(target, vDimensions, bounds)
  local halfWidth = vDimensions.width / 2
  local halfHeight = vDimensions.height / 2

  self.cam:lookAt(target.x, target.y)
  self.cam.x = MathHelper.Clamp(self.cam.x, halfWidth, bounds.width - halfWidth)
  self.cam.y = MathHelper.Clamp(self.cam.y, halfHeight, bounds.height - halfHeight)
end

return Camera

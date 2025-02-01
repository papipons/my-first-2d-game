local Decor = {}

function Decor:New(image, object)
  local decor = {
    image = image,
    object = object,
    y = object.y
  }

  setmetatable(decor, { __index = Decor })

  return decor
end

function Decor:draw()
  love.graphics.draw(
    self.image,
    self.object.x,
    self.object.y,
    0, 1, 1,
    self.image:getWidth() / 2,
    self.image:getHeight() * 0.8
  )
end

return Decor
function Clamp(value, min, max)
  return math.min(math.max(value, min), max)
end

function NormalizeVector(x, y)
  if x == 0 and y == 0 then return 0, 0 end
  local length = math.sqrt(x * x + y * y)
  return x / length, y / length
end

local helpers = {
  Clamp = Clamp,
  NormalizeVector = NormalizeVector
}

return helpers
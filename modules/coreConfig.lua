local CoreConfig = {}

function CoreConfig:load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
end

return CoreConfig
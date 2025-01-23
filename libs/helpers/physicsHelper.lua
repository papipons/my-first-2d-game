local PhysicsHelper = {}

function PhysicsHelper.createEllipseWall(object, world)
  local wall = {}
  wall.shapeType = object.shape
  wall.x = object.x + object.width / 2
  wall.y = object.y + object.height / 2
  wall.radius = object.width / 2
  wall.body = love.physics.newBody(world, wall.x, wall.y, "static")
  wall.shape = love.physics.newCircleShape(wall.radius)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)

  return wall
end

function PhysicsHelper.createPolygonWall(object, world)
  local wall = {}
  wall.shapeType = object.shape

  local vertices = {}
  for _, point in ipairs(object.polygon) do
      table.insert(vertices, point.x)
      table.insert(vertices, point.y)
  end

  wall.vertices = vertices

  wall.body = love.physics.newBody(world, 0, 0, "static")
  wall.body:setFixedRotation(true)

  wall.shape = love.physics.newPolygonShape(unpack(wall.vertices))
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)

  return wall
end

function PhysicsHelper.createRectangleWall(object, world)
  local wall = {}
  wall.shapeType = object.shape
  wall.x = object.x
  wall.y = object.y
  wall.width = object.width
  wall.height = object.height

  local bodyX = object.x + object.width / 2
  local bodyY = object.y + object.height / 2
  wall.body = love.physics.newBody(world, bodyX, bodyY, "static")
  wall.body:setFixedRotation(true)

  wall.shape = love.physics.newRectangleShape(object.width, object.height)
  wall.fixture = love.physics.newFixture(wall.body, wall.shape)

  return wall
end

return PhysicsHelper
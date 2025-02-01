local Anim8 = require 'libs/anim8'
local MathHelper = require 'libs/helpers/math'

local Player = {}

function Player:New()
  local player = setmetatable({}, { __index = Player })

  player.radius = 30
  player.speed = 400
  player.spriteWidth = 192
  player.isAttacking = false
  player.attackCooldown = 0.5
  player.attackTimer = 0

  return player
end

function Player:load(x, y, world)
  self.x = x
  self.y = y
  self:setupSprites()
  self:setupPhysics(world)
end

function Player:setupSprites()
  self.spriteSheet = love.graphics.newImage('assets/sprites/player.png')
  self.grid = Anim8.newGrid(
    self.spriteWidth,
    self.spriteWidth,
    self.spriteSheet:getWidth(),
    self.spriteSheet:getHeight()
  )

  local function onAttackEnd()
    self.isAttacking = false
    self.currentAnimation.animation = self.animations.idle
  end

  self.animations = {
    idle = Anim8.newAnimation(self.grid('1-6', 1), 0.2),
    right = Anim8.newAnimation(self.grid('1-6', 2), 0.1),
    left = Anim8.newAnimation(self.grid('1-6', 2), 0.1),
    attack = Anim8.newAnimation(self.grid('1-6', 4), 0.1, onAttackEnd)
  }

  self.currentAnimation = {
    animation = self.animations.idle,
    xScale = 1
  }
end

function Player:setupPhysics(world)
  self.body = love.physics.newBody(world, self.x, self.y, "dynamic")
  self.body:setFixedRotation(true)
  local width = self.radius * 0.9
  self.shape = love.physics.newRectangleShape(0, 13, width + 10, width + 13)
  self.fixture = love.physics.newFixture(self.body, self.shape)
end

function Player:handleAttack(dt)
  self.attackTimer = math.max(0, self.attackTimer - dt)

  if love.keyboard.isDown('space') and self.attackTimer <= 0 and not self.isAttacking then
    self.isAttacking = true
    self.attackTimer = self.attackCooldown
    self.currentAnimation.animation = self.animations.attack
    return true
  end

  return false
end

function Player:handleMovement()
  local dx, dy = 0, 0
  if love.keyboard.isDown('d') then dx = dx + 1 end
  if love.keyboard.isDown('a') then dx = dx - 1 end
  if love.keyboard.isDown('w') then dy = dy - 1 end
  if love.keyboard.isDown('s') then dy = dy + 1 end

  if dx ~= 0 and dy ~= 0 then
    dx, dy = MathHelper.NormalizeVector(dx, dy)
  end

  self.body:setLinearVelocity(dx * self.speed, dy * self.speed)

  return dx, dy
end

function Player:updateAnimation(dx, dy)
  local isMoving = dx ~= 0 or dy ~= 0
  if isMoving and dx ~= 0 then
    self.currentAnimation.xScale = dx > 0 and 1 or -1
  end

  self.currentAnimation.animation = isMoving and 
    self.animations[self.currentAnimation.xScale == 1 and 'right' or 'left'] or 
    self.animations.idle
end

function Player:update(dt, bounds)
  if self:handleAttack(dt) or self.isAttacking then
    self.currentAnimation.animation:update(dt)
    self.body:setLinearVelocity(0, 0)
    return
  end

  local dx, dy = self:handleMovement()
  self.x, self.y = self.body:getPosition()

  self:updateAnimation(dx, dy)
  self.currentAnimation.animation:update(dt)
end

function Player:draw()
  self.currentAnimation.animation:draw(
    self.spriteSheet, 
    self.x,
    self.y,
    0,
    self.currentAnimation.xScale,
    1,
    self.spriteWidth / 2,
    self.spriteWidth / 2
  )
end

return Player

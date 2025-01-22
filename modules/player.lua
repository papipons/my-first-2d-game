local Anim8 = require 'libs/anim8'
local MathHelper = require 'libs/helpers/math'

local Player = {
  radius = 30,
  speed = 400,
  spriteWidth = 192,
  isAttacking = false,
  attackCooldown = 0.5,
  attackTimer = 0
}

function Player:load(x, y)
  self.x = x
  self.y = y

  self.spriteSheet = love.graphics.newImage('assets/sprites/player.png')
  self.grid = Anim8.newGrid(
    self.spriteWidth, 
    self.spriteWidth, 
    self.spriteSheet:getWidth(), 
    self.spriteSheet:getHeight()
  )

  self.animations = {
    idle = Anim8.newAnimation(self.grid('1-6', 1), 0.2),
    right = Anim8.newAnimation(self.grid('1-6', 2), 0.1),
    left = Anim8.newAnimation(self.grid('1-6', 2), 0.1),
    attack = Anim8.newAnimation(self.grid('1-6', 4), 0.1, function()
      self.isAttacking = false
      self.currentAnimation.animation = self.animations.idle
    end)
  }

  self.currentAnimation = {
    animation = self.animations.idle,
    xScale = 1
  }
end

function Player:update(dt)
  if self.attackTimer > 0 then
    self.attackTimer = math.max(0, self.attackTimer - dt)
  end

  if love.keyboard.isDown('space') and self.attackTimer <= 0 and not self.isAttacking then
    self.isAttacking = true
    self.attackTimer = self.attackCooldown
    self.currentAnimation.animation = self.animations.attack
    return
  end

  if self.isAttacking then
    self.currentAnimation.animation:update(dt)
    return
  end

  local dx, dy = 0, 0
  if love.keyboard.isDown('d') then dx = dx + 1 end
  if love.keyboard.isDown('a') then dx = dx - 1 end
  if love.keyboard.isDown('w') then dy = dy - 1 end
  if love.keyboard.isDown('s') then dy = dy + 1 end

  if dx ~= 0 and dy ~= 0 then
    dx, dy = MathHelper.NormalizeVector(dx, dy)
  end

  local isMoving = dx ~= 0 or dy ~= 0
  if isMoving then
    self.x = self.x + (dx * self.speed * dt)
    self.y = self.y + (dy * self.speed * dt)

    if dx ~= 0 then
      self.currentAnimation.xScale = dx > 0 and 1 or -1
      self.currentAnimation.animation = self.animations[dx > 0 and 'right' or 'left']
    end
  end

  self.currentAnimation.animation = isMoving and 
    self.animations[self.currentAnimation.xScale == 1 and 'right' or 'left'] or 
    self.animations.idle

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

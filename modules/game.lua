local Push = require 'libs/push'

local Game = {
  vWidth = 640,
  vHeight = 360,
  debugMode = false,
  currentMap = require 'modules/map'
}

function Game:New()
  local game = {}

  setmetatable(game, { __index = Game })

  return game
end

function Game:startPush()
  Push:start()
end

function Game:finishPush()
  Push:finish()
end

function Game:resizePush(w, h)
  Push:resize(w, h)
end

function Game:load()
  self.virtualDimensions = {
    width = self.vWidth,
    height = self.vHeight
  }

  -- Setup window
  local windowWidth, windowHeight = love.window.getDesktopDimensions()

  self.windowWidth = windowWidth * 0.7
  self.windowHeight = windowHeight * 0.7

  love.graphics.setDefaultFilter('nearest', 'nearest')

  Push:setupScreen(
    self.vWidth,
    self.vHeight,
    self.windowWidth,
    self.windowHeight,
    { fullscreen = false, resizable = true }
  )

  -- Setup world
  self.world = love.physics.newWorld(0, 0, true)

  -- Setup Map
  self.currentMap:load(self.world)
end

function Game:update(dt)
  self.world:update(dt)

  if (love.keyboard.isDown(']')) then
    self.debugMode = true
  elseif (love.keyboard.isDown('[')) then
    self.debugMode = false
  end
end

return Game
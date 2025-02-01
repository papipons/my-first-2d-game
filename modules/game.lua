local modMap = require 'modules/map'
local Push = require 'libs/push'
local Sti = require 'libs/sti'

local Game = {}

function Game:New()
  local game = setmetatable({}, { __index = Game })
  game.vWidth, game.vHeight = 640, 360
  game.debugMode = false
  game.currentMap = modMap:New(Sti('assets/maps/map0.lua'))
  return game
end

function Game:load()
  self.virtualDimensions = { width = self.vWidth, height = self.vHeight }

  local wWidth, wHeight = love.window.getDesktopDimensions()
  self.windowWidth = wWidth * 0.7
  self.windowHeight = wHeight * 0.7

  love.graphics.setDefaultFilter('nearest', 'nearest')
  Push:setupScreen(
    self.vWidth, 
    self.vHeight,
    self.windowWidth, 
    self.windowHeight,
    { fullscreen = false, resizable = true }
  )

  self.world = love.physics.newWorld(0, 0, true)
  self.currentMap:load(self.world)
end

function Game:update(dt)
  self.world:update(dt)
  self.debugMode = love.keyboard.isDown(']') or (self.debugMode and not love.keyboard.isDown('['))
end

-- Push wrapper functions
Game.startPush = function() Push:start() end
Game.finishPush = function() Push:finish() end
Game.resizePush = function(_, w, h) Push:resize(w, h) end

return Game

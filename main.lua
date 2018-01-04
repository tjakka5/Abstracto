local Run = require("run").initialize()

local Qecs   = require("lib.qecs")
local Vector = require("lib.vector")

local Instance = Qecs.instance()
Run.addInstance(Instance)

local last = Vector(0, 0)
local pos  = Vector(0, 0)

local FramerateDisplay = Qecs.system()
function FramerateDisplay:update(dt)
   last = pos:clone()

   if love.keyboard.isDown("w") then
      pos = pos + Vector(0, -100 * dt)
   end

   if love.keyboard.isDown("a") then
      pos = pos + Vector(-100 * dt, 0)
   end

   if love.keyboard.isDown("s") then
      pos = pos + Vector(0, 100 * dt)
   end

   if love.keyboard.isDown("d") then
      pos = pos + Vector(100 * dt, 0)
   end
end

function FramerateDisplay:draw(progress)
   --love.graphics.print(love.timer.getFPS())

   local realX = last.x + (pos.x - last.x) * progress
   local realY = last.y + (pos.y - last.y) * progress
   love.graphics.circle("fill", realX, realY, 5)
end

Instance:addSystem(FramerateDisplay)

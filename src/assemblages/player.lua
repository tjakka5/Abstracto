local Fluid   = require("lib.fluid")
local Vector = require("lib.vector")

local C = require("src.components")

return function(position, up, down, left, right)
   local player = Fluid.entity()
   :give(C.transform, position or Vector(0, 0), Vector(38, 50))
   :give(C.sprite, love.graphics.newImage("assets/player/playerGreen_stand.png"), {255, 255, 255}, 1)
   :give(C.body, Vector(0, 0), 1, 7)
   :give(C.collider)
   :give(C.controls, up or "w", down or "s", left or "a", right or "d")
   :give(C.inputResponse, function(e)
      local body = e:get(C.body)
      if body.onGround then
         body.velocity.y = body.velocity.y - 800
      end
   end, function(e, dt)
   end, function(e, dt)
      local body = e:get(C.body)
      body.velocity.x = body.velocity.x - 1400 * dt
   end, function(e, dt)
      local body = e:get(C.body)
      body.velocity.x = body.velocity.x + 1400 * dt
   end)

   return player
end

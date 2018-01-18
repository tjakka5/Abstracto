local Fluid   = require("lib.Fluid")
local Vector = require("lib.vector")

local C = require("src.components")

return function(position, texture)
   local ground = Fluid.entity()
   :give(C.transform, position or Vector(0, 0), Vector(64, 64))
   :give(C.sprite, love.graphics.newImage(texture or "assets/tiles/1.png"), {255, 255, 255}, 0)
   :give(C.body, Vector(0, 0), 0, 0)
   :give(C.collider)

   return ground
end

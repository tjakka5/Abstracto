local Fluid = require("lib.Fluid")

local Sprite = Fluid.component(function(e, texture, color, depth)
   e.texture = texture
   e.color   = color
   e.depth   = depth
end)

return Sprite

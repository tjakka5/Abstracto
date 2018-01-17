local Qecs = require("lib.qecs")

local Sprite = Qecs.component(function(e, texture, color, depth)
   e.texture = texture
   e.color   = color
   e.depth   = depth
end)

return Sprite

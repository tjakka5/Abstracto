local Fluid = require("lib.Fluid")

local Collider = Fluid.component(function(e)
   e.onGround = false
end)

return Collider

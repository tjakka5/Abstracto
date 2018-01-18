local Fluid = require("lib.fluid")

local Collider = Fluid.component(function(e)
   e.onGround = false
end)

return Collider

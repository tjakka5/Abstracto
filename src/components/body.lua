local Fluid = require("lib.Fluid")

local Body = Fluid.component(function(e, velocity, gravityScale, friction)
   e.velocity     = velocity
   e.gravityScale = gravityScale
   e.friction     = friction
end)

return Body

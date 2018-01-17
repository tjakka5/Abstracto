local Qecs = require("lib.qecs")

local Body = Qecs.component(function(e, velocity, gravityScale, friction)
   e.velocity     = velocity
   e.gravityScale = gravityScale
   e.friction     = friction
end)

return Body

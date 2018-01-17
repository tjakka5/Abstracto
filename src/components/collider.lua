local Qecs = require("lib.qecs")

local Collider = Qecs.component(function(e)
   e.onGround = false
end)

return Collider

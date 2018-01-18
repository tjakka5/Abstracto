local Qecs = require("lib.qecs")

local Viewport = Qecs.component(function(e, target)
   e.target   = target
   e.attached = false

   camera = nil
end)

return Viewport

local Fluid = require("lib.fluid")

local Viewport = Fluid.component(function(e, target)
   e.target   = target
   e.attached = false

   camera = nil
end)

return Viewport

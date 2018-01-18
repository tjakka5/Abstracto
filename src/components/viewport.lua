local Fluid = require("lib.Fluid")

local Viewport = Fluid.component(function(e, target)
   e.target   = target
   e.attached = false

   camera = nil
end)

return Viewport

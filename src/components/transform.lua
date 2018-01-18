local Fluid = require("lib.Fluid")

local Transform = Fluid.component(function(e, position, size)
   e.position = position
   e.size     = size
end)

return Transform

local Fluid = require("lib.fluid")

local InputResponse = Fluid.component(function(e, up, down, left, right)
   e.up    = up
   e.down  = down
   e.left  = left
   e.right = right
end)

return InputResponse

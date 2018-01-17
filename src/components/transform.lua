local Qecs = require("lib.qecs")

local Transform = Qecs.component(function(e, position, size)
   e.position = position
   e.size     = size
end)

return Transform

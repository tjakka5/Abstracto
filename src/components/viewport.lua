local Qecs = require("lib.qecs")

local Viewport = Qecs.component(function(e, target)
   e.target = target

   camera = nil
end)

return Viewport

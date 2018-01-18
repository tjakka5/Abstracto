local Qecs   = require("lib.qecs")
local Camera = require("lib.camera")

local Transform = require("src.components.transform")
local Viewport = require("src.components.viewport")

local ViewportHandler = Qecs.system({Transform, Viewport})

function ViewportHandler:entityAdded(e)
   print(e)
   e:get(Viewport).camera = Camera(720, 720)
end

function ViewportHandler:update(update)
   for _, e in ipairs(self.pool) do
      local transform = e:get(Transform)
      local viewport  = e:get(Viewport)

      transform.position = viewport.target
      viewport.camera:lookAt(transform.position:unpack())
   end
end

function ViewportHandler:draw()
   for _, e in ipairs(self.pool) do
      local viewport = e:get(Viewport)

      if not viewport.attached then
         viewport.camera:attach()
      else
         viewport.camera:detach()
      end
   end
end

return ViewportHandler

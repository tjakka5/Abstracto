local Qecs   = require("lib.qecs")
local Camera = require("lib.camera")

local Transform = require("src.components.transform")
local Viewport = require("src.components.viewport")

local ViewportHandler = Qecs.system({Transform, Viewport})

function ViewportHandler:entityAdded(e)
   print(e)
   e:get(Viewport).camera = Camera(720, 720)
end

function ViewportHandler:update(dt)
   for _, e in ipairs(self.pool) do
      local transform = e:get(Transform)
      local viewport  = e:get(Viewport)

      transform.position = viewport.target
      viewport.camera:lookAt(transform.position:unpack())
   end
end

function ViewportHandler:preDraw()
   for _, e in ipairs(self.pool) do
      e:get(Viewport).camera:attach()
   end
end

function ViewportHandler:postDraw()
   for _, e in ipairs(self.pool) do
      e:get(Viewport).camera:detach()
   end
end

return ViewportHandler
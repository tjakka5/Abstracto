local Qecs = require("lib.qecs")

local Controls      = require("src.components.controls")
local InputResponse = require("src.components.inputResponse")

local InputHandler = Qecs.system({Controls, InputResponse})

function InputHandler:update(dt)
   for _, e in ipairs(self.pool) do
      local controls      = e:get(Controls)
      local inputResponse = e:get(InputResponse)

      for name, key in pairs(controls) do
         if love.keyboard.isDown(key) then
            inputResponse[name](e, dt)
         end
      end
   end
end

return InputHandler

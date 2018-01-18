local Fluid = require("lib.fluid")

local Controls      = require("src.components.controls")
local InputResponse = require("src.components.inputResponse")

local InputHandler = Fluid.system({Controls, InputResponse})

function InputHandler:update(update)
   for _, e in ipairs(self.pool) do
      local controls      = e:get(Controls)
      local inputResponse = e:get(InputResponse)

      for name, key in pairs(controls) do
         if love.keyboard.isDown(key) then
            inputResponse[name](e, update.dt)
         end
      end
   end
end

return InputHandler

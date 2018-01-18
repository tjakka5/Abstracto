local PATH = (...):gsub('%.init$', '')

local Qecs = {}

function Qecs.init(settings)
   Qecs.entity       = require(PATH..".entity")
   Qecs.component    = require(PATH..".component")
   Qecs.system       = require(PATH..".system")
   Qecs.instance     = require(PATH..".instance")
   Qecs.event        = require(PATH..".event")
   Qecs.eventManager = require(PATH..".eventManager")

   if settings and settings.useEvents then
      Qecs.instances = {}

      Qecs.addInstance = function(instance)
         table.insert(Qecs.instances, instance)
      end

      Qecs.removeInstance = function(instance)
         for i, instance in ipairs(Qecs.instances) do
            table.remove(Qecs.instances, i)
            break
         end
      end

      love.run = function()
         if love.math then
            love.math.setRandomSeed(os.time())
         	love.timer.step()
      	end

         for _, instance in ipairs(Qecs.instances) do
            instance:emit(Qecs.event.load(arg))
         end

      	if love.timer then love.timer.step() end

      	local dt = 0

      	while true do
      		if love.event then
      			love.event.pump()
      			for name, a, b, c, d, e, f in love.event.poll() do
                  local event = Qecs.event[name](a, b, c, d, e, f)

                  if name == "quit" then
                     event.__satisfied = true
                  end

                  for _, instance in ipairs(Qecs.instances) do
                     instance:emit(event)
                  end

                  if name == "quit" and event.__satisfied then
                     return a
                  end
      			end
      		end

      		if love.timer then
      			love.timer.step()
      			dt = love.timer.getDelta()
      		end

            for _, instance in ipairs(Qecs.instances) do
               instance:emit(Qecs.event.update(dt))
            end

            for _, instance in ipairs(Qecs.instances) do
               instance.eventManager:process()
            end

      		if love.graphics and love.graphics.isActive() then
      			love.graphics.clear(love.graphics.getBackgroundColor())
      			love.graphics.origin()

               for _, instance in ipairs(Qecs.instances) do
                  instance:emit(Qecs.event.draw())
               end

      			love.graphics.present()
      		end

      		if love.timer then love.timer.sleep(0.001) end
      	end
      end
   end

   return Qecs
end

return Qecs

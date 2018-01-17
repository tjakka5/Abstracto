local PATH = (...):gsub('%.[^%.]+$', '')

local Event = require(PATH..".event")

local Run = {
   instances = {},
}

function love.run()
	if love.math then
      love.math.setRandomSeed(os.time())
   	love.timer.step()
	end

	if love.load then love.load(arg) end

	if love.timer then love.timer.step() end

	local dt = 0

	while true do
		if love.event then
			love.event.pump()
			for name, a, b, c, d, e, f in love.event.poll() do
            local event = Event[name](a, b, c, d, e, f)

            if name == "quit" then
               event.__satisfied = true
            end

            for _, instance in ipairs(Run.instances) do
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

      for _, instance in ipairs(Run.instances) do
         instance:emit(Event.update(dt))
      end

		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()

         for _, instance in ipairs(Run.instances) do
            instance:emit(Event.draw())
         end

			love.graphics.present()
		end

		if love.timer then love.timer.sleep(0.001) end
	end
end

function Run.addInstance(instance)
   table.insert(Run.instances, instance)
end

function Run.removeInstance(instance)
   for i, instance in ipairs(Run.instances) do
      table.remove(Run.instances, i)
      break
   end
end

return Run

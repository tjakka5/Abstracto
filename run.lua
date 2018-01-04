local Run = {
   instances = {},

   desiredFramerate = 30,
   sleepTime        = 0,
   maxKeepupFrames  = 5,

   desiredDelta = 0,
   accumulator  = 0,

   quit        = nil,
   quitMessage = nil,
}

function Run.init()
   love.math.setRandomSeed(os.time())
	love.timer.step()

   Run.setDesiredFramerate(Run.desiredFramerate)
end

function Run.pollEvents()
   love.event.pump()
   for name, a, b, c, d, e, f in love.event.poll() do
      for _, instance in ipairs(Run.instances) do
         instance:callback(name, a, b, c, d, e, f)
      end

      if name == "quit" then
         Run.quit        = true
         Run.quitMessage = a
      end
   end
end

function Run.updateAccumulator()
   love.timer.step()
   Run.accumulator = Run.accumulator + love.timer.getDelta()
end

function Run.executeUpdate()
   for i = 1, Run.maxKeepupFrames do
      if Run.accumulator >= Run.desiredDelta then
         for _, instance in ipairs(Run.instances) do
            instance:callback("update", Run.desiredDelta)
         end

         Run.accumulator = Run.accumulator - Run.desiredDelta
      else
         break
      end
   end
end

function Run.executeDraw()
   if love.graphics.isActive() then
      love.graphics.clear(love.graphics.getBackgroundColor())
      love.graphics.origin()

      local frameProgress = Run.getFrameProgress()
      for _, instance in ipairs(Run.instances) do
         instance:callback("draw", frameProgress)
      end

      love.graphics.present()
   end
end

function Run.sleep()
   love.timer.sleep(Run.sleepTime)
end

function Run.loop()
   Run.pollEvents()
   Run.updateAccumulator()
   Run.executeUpdate()
   Run.executeDraw()
   Run.sleep()
end

function Run.initialize()
   love.run = function()
      Run.init()

      while true do
         Run.loop()

         if Run.quit then
            return Run.quitMessage
         end
      end
   end

   return Run
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

function Run.setDesiredFramerate(framerate)
   Run.desiredFramerate = framerate
   Run.desiredDelta     = 1 / Run.desiredFramerate
end

function Run.getDesiredFramerate()
   return Run.desiredFramerate
end

function Run.getDesiredDelta()
   return Run.desiredDelta
end

function Run.getFrameProgress()
   return Run.accumulator / Run.desiredDelta
end

return Run

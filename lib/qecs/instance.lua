local PATH = (...):gsub('%.[^%.]+$', '')

local Pool         = require(PATH..".pool")
local Event        = require(PATH..".event")
local EventManager = require(PATH..".eventManager")

local Instance = {}
Instance.__index = Instance

function Instance.new()
   local instance = setmetatable({
      entities     = Pool(),
      eventManager = EventManager(),

      systems      = {},
      namedSystems = {},
   }, Instance)

   return instance
end

function Instance:addEntity(e)
   e.instance = self
   self.entities:add(e)
   self:checkEntity(e)
end

function Instance:checkEntity(e)
   for _, system in ipairs(self.systems) do
      if system:check(e) then
         e.systems[#e.systems + 1] = system
      end
   end
end

function Instance:destroyEntity(e)
   self.entities:remove(e)

   for _, system in ipairs(e.systems) do
      system:remove(e)
   end
end

function Instance:addSystem(system, eventName)
   if not self.namedSystems[system] then
      self.systems[#self.systems + 1] = system
      self.namedSystems[system]       = system
   end

   self.eventManager:register(eventName, system)
end

function Instance:removeSystem(system)
   for index, other in ipairs(self.systems) do
      if system == other then
         table.remove(self.systems, index)
      end
   end

   self.namedSystems[system] = nil
end

function Instance:emit(event)
   self.eventManager:emit(event)
end

function Instance:update(dt)
   self:emit(Event.update(dt))
end

function Instance:draw()
   self:emit(Event.draw())
end

return setmetatable(Instance, {
   __call = function(_, ...) return Instance.new(...) end,
})

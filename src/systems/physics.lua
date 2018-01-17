local Qecs = require("lib.qecs")
local Bump = require("lib.bump")

local Transform = require("src.components.transform")
local Body      = require("src.components.body")
local Collider  = require("src.components.collider")

local Physics = Qecs.system({Transform, Body}, {Transform, Body, Collider, "colliding"})
Physics.world   = Bump.newWorld(128)
Physics.gravity = 1200

Physics.debugDraw = true

function Physics:entityAddedAny(e, pool)
   if pool.__name == "colliding" then
      local transform = e:get(Transform)
      local body      = e:get(Body)

      self.world:add(body, transform.position.x, transform.position.y, transform.size.x, transform.size.y)
   end
end

function Physics:entityRemovedAny(e, pool)
   if pool.__name == "colliding" then
      self.world:remove(body)
   end
end

function Physics:update(dt)
   for _, e in ipairs(self.pool) do
      local transform = e:get(Transform)
      local body      = e:get(Body)

      body.velocity.y = body.velocity.y + (self.gravity * body.gravityScale * dt)

      local friction = body.velocity:clone()
      friction = friction * -body.friction

      body.velocity = body.velocity + friction * dt

      transform.position = transform.position + body.velocity * dt

      if e:has(Collider) then
         local newX, newY, cols, len = self.world:move(body, transform.position.x, transform.position.y)
         transform.position.x = newX
         transform.position.y = newY

         body.onGround = false
         for i = 1, len do
            local col = cols[i]

            if col.normal.x ~= 0 then
               body.velocity.x = 0
            end

            if col.normal.y ~= 0 then
               body.velocity.y = 0
            end

            if col.normal.y == -1 then
               body.onGround = true
            end
         end
      end
   end
end

function Physics:draw()
   if self.debugDraw then
      for _, e in ipairs(self.colliding) do
         local transform = e:get(Transform)
         local body      = e:get(Body)

         love.graphics.rectangle("line", transform.position.x, transform.position.y, transform.size.x, transform.size.y)
      end
   end
end

return Physics

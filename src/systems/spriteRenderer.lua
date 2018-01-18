local Fluid = require("lib.fluid")

local Transform = require("src.components.transform")
local Sprite    = require("src.components.sprite")

local SpriteRenderer = Fluid.system({Transform, Sprite})

local function sort(a, b)
   return a:get(Sprite).depth < b:get(Sprite).depth
end

function SpriteRenderer:draw()
   table.sort(self.pool, sort)

   for _, e in ipairs(self.pool) do
      local transform = e:get(Transform)
      local sprite    = e:get(Sprite)

      local ox = sprite.texture:getWidth()/2
      local oy = sprite.texture:getHeight()/2

      love.graphics.setColor(sprite.color)
      love.graphics.draw(sprite.texture, transform.position.x + ox, transform.position.y + oy, transform.rotation, nil, nil, ox, oy)
   end
end

return SpriteRenderer

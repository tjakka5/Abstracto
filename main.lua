local Qecs   = require("lib.qecs")
local Vector = require("lib.vector")

local Game = require("src.instances.game")

local Transform     = require("src.components.transform")
local Sprite        = require("src.components.sprite")
local Body          = require("src.components.body")
local Controls      = require("src.components.controls")
local InputResponse = require("src.components.inputResponse")
local Viewport      = require("src.components.viewport")
local Collider      = require("src.components.collider")

local Physics         = require("src.systems.physics")
local SpriteRenderer  = require("src.systems.spriteRenderer")
local InputHandler    = require("src.systems.inputHandler")
local ViewportHandler = require("src.systems.viewportHandler")

Game:addSystem(SpriteRenderer, "draw")
Game:addSystem(Physics, "update")
Game:addSystem(InputHandler, "update")
--Game:addSystem(ViewportHandler, "draw")

local Player = Qecs.entity()
Player:give(Transform, Vector(213, 0), Vector(38, 50))
Player:give(Sprite, love.graphics.newImage("assets/player/playerGreen_stand.png"), {255, 255, 255}, 1)
Player:give(Body, Vector(0, 0), 1, 7)
Player:give(Collider)
Player:give(Controls, "w", "s", "a", "d")
Player:give(InputResponse, function(e)
   local body = e:get(Body)
   if body.onGround then
      body.velocity.y = body.velocity.y - 800
   end
end, function(e, dt)
end, function(e, dt)
   local body = e:get(Body)
   body.velocity.x = body.velocity.x - 1400 * dt
end, function(e, dt)
   local body = e:get(Body)
   body.velocity.x = body.velocity.x + 1400 * dt
end)

local Ground = Qecs.entity()
Ground:give(Transform, Vector(200, 400), Vector(64, 64))
Ground:give(Sprite, love.graphics.newImage("assets/tiles/1.png"), {255, 255, 255}, 0)
Ground:give(Body, Vector(0, 0), 0, 0)
Ground:give(Collider)

local Camera = Qecs.entity()
Camera:give(Transform, Vector(0, 0), Vector(0, 0))
Camera:give(Viewport, Ground:get(Transform).position)

Game:addEntity(Player)
Game:addEntity(Ground)
Game:addEntity(Camera)

Qecs.run.addInstance(Game)

local Qecs   = require("lib.qecs").init({
   useEvents = true
})
local Vector = require("lib.vector")

local Game = require("src.instances.game")

local C = require("src.components")
local S = require("src.systems")
local A = require("src.assemblages")

local Physics         = require("src.systems.physics")
local SpriteRenderer  = require("src.systems.spriteRenderer")
local InputHandler    = require("src.systems.inputHandler")

Game:addSystem(S.physics,      "update")
Game:addSystem(S.inputHandler, "update")

Game:addSystem(S.spriteRenderer, "draw")

Game:addEntity(A.player(Vector(0, 0)))
Game:addEntity(A.tile(Vector(0, 200)))

Qecs.addInstance(Game)

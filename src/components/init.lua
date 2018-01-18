local PATH = (...):gsub('%.init$', '')

return {
   body          = require(PATH..".body"),
   collider      = require(PATH..".collider"),
   controls      = require(PATH..".controls"),
   inputResponse = require(PATH..".inputResponse"),
   sprite        = require(PATH..".sprite"),
   transform     = require(PATH..".transform"),
   viewport      = require(PATH..".viewport"),
}

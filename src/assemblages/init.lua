local PATH = (...):gsub('%.init$', '')

return {
   player = require(PATH..".player"),
   tile   = require(PATH..".tile"),
}

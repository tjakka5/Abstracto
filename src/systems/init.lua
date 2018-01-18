local PATH = (...):gsub('%.init$', '')

return {
   inputHandler    = require(PATH..".inputHandler"),
   physics         = require(PATH..".physics"),
   spriteRenderer  = require(PATH..".spriteRenderer"),
   viewportHandler = require(PATH..".viewportHandler"),
}

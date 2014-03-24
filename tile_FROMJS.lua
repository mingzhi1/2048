-- "Find-And-Replace"-like JavaScript to Lua by Arthur200000
-- Vim says there is still some mistakes left.
-- Arthur200000 thinks that it is still partly JavaScript. Maybe we need Lua with Braces, just like PythonB.

function Tile(position, value) 
  this.x                = position.x
  this.y                = position.y
  this.value            = value or 2

  this.previousPosition = null
  this.mergedFrom       = null -- Tracks tiles that merged together
end

Tile.prototype.savePosition = function() 
  this.previousPosition = { x: this.x, y: this.y }
end

Tile.prototype.updatePosition = function(position) 
  this.x = position.x
  this.y = position.y
end

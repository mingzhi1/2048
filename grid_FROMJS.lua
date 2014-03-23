-- "Find-And-Replace"-like JavaScript to Lua by Arthur200000
-- Vim says there is no mistakes left. But no one think so.
-- Arthur200000 thinks that it is still partly JavaScript. Maybe we need Lua with Braces, just like PythonB.



function Grid(size) 
  this.size = size

  this.cells = []

  this.build()
end

-- Build a grid of the specified size
Grid.prototype.build = function() 
  for var x = 0 x < this.size x++ do
    var row = this.cells[x] = []

    for var y = 0 y < this.size y++ do
      row.push(null)
    end
  end
end

-- Find the first available random position
Grid.prototype.randomAvailableCell = function() 
  var cells = this.availableCells()

  if cells.length then
    return cells[Math.floor(Math.random() * cells.length)]
  end
end

Grid.prototype.availableCells = function() 
  var cells = []

  this.eachCell(function(x, y, tile) 
    if !tile then
      cells.push({ x: x, y: y })
    end
  end)

  return cells
end

-- Call callback for every cell
Grid.prototype.eachCell = function(callback) 
  for var x = 0 x < this.size x++ do
    for var y = 0 y < this.size y++ do
      callback(x, y, this.cells[x][y])
    end
  end
end

-- Check if there are any cells available
Grid.prototype.cellsAvailable = function() 
  return !!this.availableCells().length
end

-- Check if the specified cell is taken
Grid.prototype.cellAvailable = function(cell) 
  return !this.cellOccupied(cell)
end

Grid.prototype.cellOccupied = function(cell) 
  return !!this.cellContent(cell)
end

Grid.prototype.cellContent = function(cell) 
  if this.withinBounds(cell) then
    return this.cells[cell.x][cell.y]
  else 
    return null
  end
end

-- Inserts a tile at its position
Grid.prototype.insertTile = function(tile) 
  this.cells[tile.x][tile.y] = tile
end

Grid.prototype.removeTile = function(tile) 
  this.cells[tile.x][tile.y] = null
end

Grid.prototype.withinBounds = function(position) 
  return position.x >= 0 && position.x < this.size &&
         position.y >= 0 && position.y < this.size
end

-- "Find-And-Replace"-like JavaScript to Lua by Arthur200000
-- Vim says there is still some mistakes left.
-- Arthur200000 thinks that it is still partly JavaScript. Maybe we need Lua with Braces, just like PythonB.
--[[ Why are you reading the poorly-translated code?

　　　　　　　　┏┓　　┏┓ 
　　　　　　 　┏┛┻━━━━┛┻┓ 
　　　　　　 　┃　　　　┃ 　 
　　　　　　 　┃　　━ 　┃ 
　　　　　　 　┃　┳┛　┗┳┃ 
　　　　　　 　┃　　　　┃ 
　　　　　　 　┃　　┻　 ┃ 
　　　　　　 　┃　　　　┃ 
　　　　　　 　┗━┓　　┏━┛ 
　　　　　 　　　┃　　┃　　　　　　　　　　　 
　　　　 　　　　┃　　┃ 
　　　 　　　　　┃　　┗━━━┓ 
　　 　　　　　　┃　　　　┣┓ 
　 　　　　　　　┃　 　　┏┛ 
 　　　　　　　　┗┓┓┏━┳┓┏┛ 
　　　　　　　　　┃┫┫　┃┫┫ 
　　　　　　　　　┗┻┛　┗┻┛ --]]

GameManager = function(size, InputManager, Actuator, ScoreManager) 
  this.size         = size -- Size of the grid
  this.inputManager = new InputManager
  this.scoreManager = new ScoreManager
  this.actuator     = new Actuator

  this.startTiles   = 2

  this.inputManager.on("move", this.move.bind(this))
  this.inputManager.on("restart", this.restart.bind(this))
  this.inputManager.on("keepPlaying", this.keepPlaying.bind(this))

  this.setup()
end

-- Restart the game
GameManager.prototype.restart = function() 
  this.actuator.continue()
  this.setup()
end

-- Keep playing after winning
GameManager.prototype.keepPlaying = function() 
  this.keepPlaying = true
  this.actuator.continue()
end

GameManager.prototype.isGameTerminated = function() 
  if this.over or (this.won and not this.keepPlaying) then
    return true
  else 
    return false
  end
end

-- Set up the game
GameManager.prototype.setup = function() 
  this.grid        = new Grid(this.size)

  this.score       = 0
  this.over        = false
  this.won         = false
  this.keepPlaying = false

  -- Add the initial tiles
  this.addStartTiles()

  -- Update the actuator
  this.actuate()
end

-- Set up the initial tiles to start the game with
GameManager.prototype.addStartTiles = function()
  for var i = 0 i < this.startTiles i++ do
        this.addRandomTile()
    end
end

-- Adds a tile in a random position
GameManager.prototype.addRandomTile = function() 
  if this.grid.cellsAvailable() then
    var value = Math.random() < 0.9 ? 2 : 4
    var tile = new Tile(this.grid.randomAvailableCell(), value)

    this.grid.insertTile(tile)
  end
end

-- Sends the updated grid to the actuator
GameManager.prototype.actuate = function() 
  if this.scoreManager.get() < this.score then
    this.scoreManager.set(this.score)
  end
  this.actuator.actuate(this.grid, {
    score:      this.score,
    over:       this.over,
    won:        this.won,
    bestScore:  this.scoreManager.get(),
    terminated: this.isGameTerminated()
  })
end

-- Save all tile positions and remove merger info
GameManager.prototype.prepareTiles = function() 
  this.grid.eachCell(function(x, y, tile) 
    if tile then
      tile.mergedFrom = null
      tile.savePosition()
    end
  end)
end

-- Move a tile and its representation
GameManager.prototype.moveTile = function(tile, cell) 
  this.grid.cells[tile.x][tile.y] = null
  this.grid.cells[cell.x][cell.y] = tile
  tile.updatePosition(cell)
end

-- Move tiles on the grid in the specified direction
GameManager.prototype.move = function(direction) 
  -- 0: up, 1: right, 2:down, 3: left
  var self = this

  if this.isGameTerminated() then return end -- Don't do anything if the game's over

  var cell, tile

  var vector     = this.getVector(direction)
  var traversals = this.buildTraversals(vector)
  var moved      = false

  -- Save the current tile positions and remove merger information
  this.prepareTiles()

  -- Traverse the grid in the right direction and move tiles
  traversals.x.forEach(function(x) 
    traversals.y.forEach(function(y) 
      cell = { x: x, y: y }
      tile = self.grid.cellContent(cell)

      if tile then
        var positions = self.findFarthestPosition(cell, vector)
        var next      = self.grid.cellContent(positions.next)

        -- Only one merger per row traversal?
        if next and next.value === tile.value and not next.mergedFrom then
          var merged = new Tile(positions.next, tile.value * 2)
          merged.mergedFrom = [tile, next]

          self.grid.insertTile(merged)
          self.grid.removeTile(tile)

          -- Converge the two tiles' positions
          tile.updatePosition(positions.next)

          -- Update the score
          self.score += merged.value

          -- The mighty 2048 tile
          if merged.value === 2048 then
              self.won = true
          else  
              self.moveTile(tile, positions.farthest)
       

        if not self.positionsEqual(cell, tile) then
          moved = true -- The tile moved from its original cell!
        end
      end
    end -- What happened to the syntax?
  end

  if moved then
    this.addRandomTile()

    if not this.movesAvailable() then
      this.over = true -- Game over!
    end

    this.actuate()
  end
end

-- Get the vector representing the chosen direction
GameManager.prototype.getVector = function(direction) 
  -- Vectors representing tile movement
  var map = {
    0: { x: 0,  y: -1 }, -- up
    1: { x: 1,  y: 0 },  -- right
    2: { x: 0,  y: 1 },  -- down
    3: { x: -1, y: 0 }   -- left
  }

  return map[direction]
end

-- Build a list of positions to traverse in the right order
GameManager.prototype.buildTraversals = function(vector) 
  var traversals = { x: [], y: [] }

  for var pos = 0 pos < this.size pos++ do
    traversals.x.push(pos)
    traversals.y.push(pos)
  end

  -- Always traverse from the farthest cell in the chosen direction
  if vector.x === 1 then traversals.x = traversals.x.reverse() end
  if vector.y === 1 then traversals.y = traversals.y.reverse() end

  return traversals
end

GameManager.prototype.findFarthestPosition = function(cell, vector) 
  var previous

  -- Progress towards the vector direction until an obstacle is found
  do {
    previous = cell
    cell     = { x: previous.x + vector.x, y: previous.y + vector.y }
  } while this.grid.withinBounds(cell) and
           this.grid.cellAvailable(cell) do

  return {
    farthest: previous,
    next: cell -- Used to check if a merge is required
  }
end 

GameManager.prototype.movesAvailable = function() 
  return this.grid.cellsAvailable() or this.tileMatchesAvailable()
end

-- Check for available matches between tiles (more expensive check)
GameManager.prototype.tileMatchesAvailable = function() 
  var self = this

  var tile

  for var x = 0 x < this.size x++ do
    for var y = 0 y < this.size y++ do
      tile = this.grid.cellContent({ x: x, y: y })

      if tile then
        for var direction = 0 direction < 4 direction++ do
          var vector = self.getVector(direction)
          var cell   = { x: x + vector.x, y: y + vector.y }

          var other  = self.grid.cellContent(cell)

          if other and other.value === tile.value then
            return true -- These two tiles can be merged
          end
        end
      end
    end
  end

  return false
end

GameManager.prototype.positionsEqual = function(first, second) 
  return first.x === second.x and first.y === second.y
end

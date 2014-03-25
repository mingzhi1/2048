-- 2048 for TI-Nspire, NOT WORKING YET
-- Original JavaScript Source: https://github.com/gabrielecirulli/2048/tree/master/js
-- I don't have to work so much if there is a JavaScript to Lua compiler. However there isn't. http://lua-users.org/lists/lua-l/2011-11/msg00668.html
--[[ (Long Copyrights) --]]
-- platform.apilevel = '1.0'   -- TI-Lua API version, used for var funcs to store highscores and maybe Save/Load for the game.

size = 4
score = 0
powers = {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536}
over = False

init = function() --generates an empty size-by-size table. 
    Tile = {}
    for row=1,size do
        Tile[row] = {}
        for col=1,size do
            Tile[row][col]= 1
        end
    end
end

checkscore = function()
    var.store("lastscore", score)
    if var.recall("topscore") < score or var.recall("topscore") == nil then
        var.store("topscore", score)
    end
end

restartGame = function()
    --TODO
    checkscore()
    this.init()
end

continueGame = function()
    --TODO:Simply delete the buttons drawn.
    checkscore()
    --TODO:Remember to draw a restart button (init only actually) , or just draw it at init.
end

isGameTerminated = function() --directly translated from JavaScript
   if this.over or (this.won and not this.keepPlaying) then --LOTS OF STUBS
     return true
   else
     return false
   end
 end


function on.arrowRight() --others in the same way
    if not over then
        cells = this.availableCells(right)
        this.push(right)
        this.merge(right)
        this.push(right) --Can I avoid Pushing twice?
    end
end

availableCells = function(direcion)
    --TODO: Let pichu the OIer do this
end

push = function(direction)
    -- TODO: Let pichu the OIer do this
end

merge = function (direction) --Seems stupid, Hmm.
    if direction == up then
    for i=1, size do
        for j=1, size do
            if BL[i][j] == BL[i][j+1] then
                BL[i][j] = BL[i][j]+1 
                BL[i][j+1] = 0
            end
        end
    end
end

randomAvailableCell = function()
    -- Get this before pushing 
    -- Choose from var.recallAt(cells, RandomFromOne_To_ElementCountOfCells)
    -- TODO: Let pichu the OIer do this
end

addRandomTile = function()
    -- Do after pushing
    cell = this.randomAvailableCell --{x, y}
    block = math.random(1,2)
    Tile [var.recallAt("cell", 1) ][var.recallAt("cell", 2)] = var.recall(block)
end


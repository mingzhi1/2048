-- 2048 for TI-Nspire, NOT WORKING YET
-- Original JavaScript Source: https://github.com/gabrielecirulli/2048/tree/master/js
--[[ (Long Copyrights) --]]
-- platform.apilevel = '2.0'   -- TI-Lua API version, maybe I don't need so many TI APIs.

size = 4
score = 0
player = 
powers = {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024}
over = False

Tile = {}
for row=1,size do
    Tile[row] = {}
    for col=1,size do
        Tile[row][col]= 1
    end
end

functi

function on.arrowRight()
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


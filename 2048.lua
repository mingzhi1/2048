-- platform.apilevel = '2.0'     

size = 4
score = 0
player = 
powers = {2, 4, 8, 16, 32, 64, 128, 256, 512, 1024}

Tile = {}
for row=1,size do
    Tile[row] = {}
    for col=1,size do
        Tile[row][col]= 1
    end
end

push = function(direction)
    
end

randomAvailableCell = function()
    
end

addRandomTile = function()
    cell = this.randomAvailableCell --{x, y}
    block = math.random(1,2)
    Tile [var.recallAt("cell", 1) ][var.recallAt("cell", 2)] = var.recall(block)
end


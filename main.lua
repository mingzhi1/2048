
grids = {
    cells = nil,
    size = 0
}

Tile = {
    x = 0,
    y = 0,
    value = 0,
}

function Tile:new(cells)
    math.randomseed(os.time())
    local idx = math.random(1, table.getn(cells))
    self.x = cells[idx].x
    self.y = cells[idx].y
    if math.random(1,10) == 9 then
        self.value = 4
    else
        self.value = 2
    end
end

function grids:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function grids:empty()
    local cells = {}

    for x = 0, self.size do
        cells[x] = {}
        for y = 0, self.size do
            cells[x][y] = 0
        end
    end

    self.cells = cells
end

--[[
direction
        up
        1
left 4      2 right
        3
       down
]]
function grids:move(direction)
    if direction == 1 then
        for i = 1, self.size do
            for j =1, self.size-1 do
                if self.cells[i][j] == self.cells[i][j+1] then
                    self.cells[i][j] = self.cells[i][j] + self.cells[i][j]
                    self.cells[i][j+1] = 0
                end
                if self.cells[i][j] == 0 then
                    self.cells[i][j] = self.cells[i][j+1]
                    self.cells[i][j+1] = 0
                end
            end
        end
    elseif direction == 2 then
        for i = 1, self.size do
            for j =self.size, 2 do
                if self.cells[j][i] == self.cells[j-1][i] then
                    self.cells[j][i] = self.cells[j][i] + self.cells[j][i]
                    self.cells[j-1][i] = 0
                end
                if self.cells[j][i] == 0 then
                    self.cells[j][i] = self.cells[j-1][i]
                    self.cells[j-1][i] = 0
                end
            end
        end
    elseif direction == 3 then
        for i = 1, self.size do
            for j =self.size, 2 do
                if self.cells[i][j] == self.cells[i][j-1] then
                    self.cells[i][j] = self.cells[i][j] + self.cells[i][j]
                    self.cells[i][j-1] = 0
                end
                if self.cells[i][j] == 0 then
                    self.cells[i][j] = self.cells[i][j-1]
                    self.cells[i][j-1] = 0
                end
            end
        end
    elseif direction == 4 then
        for i = 1, self.size do
            for j =1, self.size-1 do
                if self.cells[j][i] == self.cells[j+1][i] then
                    self.cells[j][i] = self.cells[j][i] + self.cells[j][i]
                    self.cells[j+1][i] = 0
                end
                if self.cells[j][i] == 0 then
                    self.cells[j][i] = self.cells[j+1][i]
                    self.cells[j+1][i] = 0
                end
            end
        end
    end
end

function grids:availables()
    local cells = {}
    for i = 0, self.size do
        for j = 0, self.size do
            if self.cells[i][j] == 0 then
                table.insert(cells, {x = i, y = j})
            end
        end
    end
    return cells
end

function grids:insert(tile)
    self.cells[tile.x][tile.y] = tile.value
end

function grids:remove(tile)
    self.cells[tile.x][tile.y] = 0
end


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
    local idx = math.random(1,table.getn(cells))
    self.x = cells[idx].x
    self.y = cells[idx].y
    if math.random(1,10) == 9 then
    	self.value = 4
    else
    	self.value = 2
    end
end

function Tile:update(position, value)
    self.x = position.x
    self.y = position.y
    self.value = self.value + value
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

function grids:merge()

end

function grids:move(direction)
	-- body
end

function grids:availables()
	local cells = {}
	for i = 0, self.size do
		for j = 0, self.size do
			if self.cells[i][j] == nil then
				table.insert(cells, {x = i, y = j})
			end
		end
	end
	return cells
end

function grids:insert(tile)
	self.cells[tile.x][tile.y] = tile
end

function grids:remove(tile)
	self.cells[tile.x][tile.y] = nil
end

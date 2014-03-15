
girds = {
}

Tile = {
    x = 0,
    y = 0,
    value = 0,
}

function Tile:new()
    math.randomseed(os.time())
    x     = math.random(1,4)
    y     = math.random(1,4)
    value = 2
end

function Tile:updatePosition(position)
    x = position.x;
    y = position.y;
end

function girds:merge()

end

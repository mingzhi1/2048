
girds = {
}

Tile = {
    x = 0,
    y = 0,
    value = 0,
}

function Tile:new(position, value)
    x     = position.x;
    y     = position.y;
    value = value || 2;
end

function Tile:updatePosition(position)
    x = position.x;
    y = position.y;
end

function girds:merge()

end

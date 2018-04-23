local map = {}
local settings = require("settings")

map.grid = {
    { 1,14,14, 2, 1, 1, 1, 1, 5, 1},
    {14,14,14, 5, 1, 1, 1, 1, 5, 1},
    {14,14, 1, 5, 1, 1, 1, 1, 2, 1},
    {14, 1, 1, 2, 1, 1, 1, 1, 2, 1},
    {14, 1, 1, 5, 1, 1, 1, 1, 5, 1},
    { 1, 1, 1, 2, 1, 7, 7, 7, 8, 7},
    { 6, 3, 6, 4, 9,11, 9,11,12, 9},
    { 1, 1, 1, 8, 7, 7,13,13,10,13},
    { 1, 1, 7,10, 7,13,13,13, 8,13},
    { 1, 1, 7, 8, 7, 7,13,13, 8,13}
}
map.tileSheet = nil
map.tileTexture = {}
map.solidTiles = {13, 14}
map.fogGrid = {}

function map.load()
    map.tileSheet = love.graphics.newImage("assets/tileset.png")
    -- get tiles
    local cols = map.tileSheet:getWidth() / settings.TILE_SIZE
    local rows = map.tileSheet:getHeight() / settings.TILE_SIZE
    local r, c
    local tileId = 0
    map.tileTexture[tileId] = nil
    for r = 1, rows do
        for c = 1, cols do
            if not (tileId == 0) then
                map.tileTexture[tileId] = love.graphics.newQuad(
                    (c-1) * settings.TILE_SIZE, 
                    (r-1) * settings.TILE_SIZE, 
                    settings.TILE_SIZE, settings.TILE_SIZE, 
                    map.tileSheet:getWidth(), map.tileSheet:getHeight()
                )
            end
            tileId = tileId + 1
        end
    end
    -- fog initialization
    for r = 1, settings.MAP_WIDTH do
        map.fogGrid[r] = {}
        for c = 1, settings.MAP_HEIGHT do
            map.fogGrid[r][c] = 1
        end
    end
end

function map.isSolid(x, y)
    local i
    for i = 1, #map.solidTiles do
        if map.grid[y+1][x+1] == map.solidTiles[i] then
            return true
        end
    end
    return false
end

function map.clearFog(x, y)
    local c, r
    for c = x, x+2 do
        for r = y, y+2 do
            if (c > 0 and c <= settings.MAP_WIDTH and r > 0 and r <= settings.MAP_HEIGHT) then
                map.fogGrid[r][c] = 0
            end
        end
    end
end



function map.draw()
    local r, c
    local tileId = 0
    local tile = nil
    for r = 1, settings.MAP_WIDTH do
        for c = 1, settings.MAP_HEIGHT do
            tileId = map.grid[r][c]
            tile = map.tileTexture[tileId]
            if tile ~= nil then
                -- draw tile
                local x = (c-1) * settings.TILE_SIZE
                local y = (r-1) * settings.TILE_SIZE
                love.graphics.draw(map.tileSheet, tile, x, y)
                -- draw fog
                if map.fogGrid[r][c] > 0 then
                    love.graphics.setColor(0, 0, 0, 1)
                    love.graphics.rectangle("fill", x, y, settings.TILE_SIZE, settings.TILE_SIZE)
                    love.graphics.setColor(1, 1, 1, 1)
                end
            end
        end
    end
end

return map
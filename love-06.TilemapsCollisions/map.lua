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
                love.graphics.draw(map.tileSheet, tile, (c-1) * settings.TILE_SIZE, (r-1) * settings.TILE_SIZE)
            end
        end
    end
end

return map
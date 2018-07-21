local map = {}
local settings = require("settings")

map.grid = {
    { 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 2, 2, 2, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 3, 3, 3, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
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
                -- draw tile
                local x = (c-1) * settings.TILE_SIZE
                local y = (r-1) * settings.TILE_SIZE
                love.graphics.draw(map.tileSheet, tile, x, y)
            end
        end
    end
end

return map
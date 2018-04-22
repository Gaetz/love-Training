local TILE_SIZE = 8
local MAP_WIDTH = 10
local MAP_HEIGHT = 10
local SCALE = 5

local Game = {}

Game.map = {
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

Game.tileSheet = nil
Game.tileTexture = {}

function Game.load()
    Game.tileSheet = love.graphics.newImage("assets/tileset.png")
    -- get tiles
    local cols = Game.tileSheet:getWidth() / TILE_SIZE
    local rows = Game.tileSheet:getHeight() / TILE_SIZE
    local r, c
    local tileId = 0
    Game.tileTexture[tileId] = nil
    for r = 1, rows do
        for c = 1, cols do
            if not (tileId == 0) then
                Game.tileTexture[tileId] = love.graphics.newQuad(
                    (c-1) * TILE_SIZE, 
                    (r-1) * TILE_SIZE, 
                    TILE_SIZE, TILE_SIZE, 
                    Game.tileSheet:getWidth(), Game.tileSheet:getHeight()
                )
            end
            tileId = tileId + 1
        end
    end
end

function Game.draw()
    -- draw map
    local r, c
    local tileId = 0
    local tile = nil
    for r = 1, MAP_WIDTH do
        for c = 1, MAP_HEIGHT do
            tileId = Game.map[r][c]
            tile = Game.tileTexture[tileId]
            if tile ~= nil then
                love.graphics.draw(Game.tileSheet, tile, (c-1) * TILE_SIZE, (r-1) * TILE_SIZE)
            end
        end
    end
end

function Game.drawDebug()
    -- draw tile id
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local row = math.floor(y / TILE_SIZE / SCALE) + 1
    local col = math.floor(x / TILE_SIZE / SCALE) + 1
    local id = Game.map[row][col]
    love.graphics.print({ { 0, 0, 1, 1} , "Id:"..tostring(id) }, 0, 0)
end

return Game
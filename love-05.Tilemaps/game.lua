local TILE_SIZE = 8
local MAP_WIDTH = 10
local MAP_HEIGHT = 10

local Game = {}

Game.Map = {}
Game.Map = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 5, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 7, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
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
    local r, c
    local tileId = 0
    local tile = nil
    for r = 1, MAP_WIDTH do
        for c = 1, MAP_HEIGHT do
            tileId = Game.Map[r][c]
            tile = Game.tileTexture[tileId]
            if tile ~= nil then
                love.graphics.draw(Game.tileSheet, tile, (c-1) * TILE_SIZE, (r-1) * TILE_SIZE)
            end
        end
    end
end

return Game
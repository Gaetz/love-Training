local game = {}

game.hero = require("hero")
local settings = require("settings")

game.map = {
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

game.tileSheet = nil
game.tileTexture = {}

function game.load()
    game.tileSheet = love.graphics.newImage("assets/tileset.png")
    -- get tiles
    local cols = game.tileSheet:getWidth() / settings.TILE_SIZE
    local rows = game.tileSheet:getHeight() / settings.TILE_SIZE
    local r, c
    local tileId = 0
    game.tileTexture[tileId] = nil
    for r = 1, rows do
        for c = 1, cols do
            if not (tileId == 0) then
                game.tileTexture[tileId] = love.graphics.newQuad(
                    (c-1) * settings.TILE_SIZE, 
                    (r-1) * settings.TILE_SIZE, 
                    settings.TILE_SIZE, settings.TILE_SIZE, 
                    game.tileSheet:getWidth(), game.tileSheet:getHeight()
                )
            end
            tileId = tileId + 1
        end
    end
    -- get hero
    game.hero.load()
end

function game.update(dt)
    game.hero.update(dt)
end

function game.draw()
    -- draw map
    local r, c
    local tileId = 0
    local tile = nil
    for r = 1, settings.MAP_WIDTH do
        for c = 1, settings.MAP_HEIGHT do
            tileId = game.map[r][c]
            tile = game.tileTexture[tileId]
            if tile ~= nil then
                love.graphics.draw(game.tileSheet, tile, (c-1) * settings.TILE_SIZE, (r-1) * settings.TILE_SIZE)
            end
        end
    end
    -- draw hero
    game.hero.draw()
end

function game.drawDebug()
    -- draw tile id
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local row = math.floor(y / settings.TILE_SIZE / settings.SCALE) + 1
    local col = math.floor(x / settings.TILE_SIZE / settings.SCALE) + 1
    local id = game.map[row][col]
    love.graphics.print({ { 0, 0, 1, 1} , "Id:"..tostring(id) }, 0, 0)
end

return game
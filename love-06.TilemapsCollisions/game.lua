local game = {}
local settings = require("settings")

game.hero = require("hero")
game.map = require("map")

function game.load()
    game.map.load()
    game.hero.load(game.map)
end

function game.update(dt)
    game.hero.update(dt, game.map)
end

function game.draw()
    game.map.draw()
    game.hero.draw()
end

function game.drawDebug()
    -- draw tile id
    local x = love.mouse.getX()
    local y = love.mouse.getY()
    local row = math.floor(y / settings.TILE_SIZE / settings.SCALE) + 1
    local col = math.floor(x / settings.TILE_SIZE / settings.SCALE) + 1
    local id = game.map.grid[row][col]
    love.graphics.print({ { 0, 0, 1, 1} , "Id:"..tostring(id) }, 0, 0)
end

return game
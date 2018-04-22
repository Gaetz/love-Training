local hero = {}

local settings = require("settings")

function hero.load()
    hero.tileSheet = love.graphics.newImage("assets/knight.png")
    hero.directionTexture = {}
    local i
    for i = 0, 3 do
        hero.directionTexture[i] = love.graphics.newQuad(
            0, i * settings.TILE_SIZE, 
            settings.TILE_SIZE, settings.TILE_SIZE, 
            hero.tileSheet:getWidth(), hero.tileSheet:getHeight()
        )
    end
    
    hero.direction = 0
    hero.x = 3
    hero.y = 3
end

function hero.update(dt)
    
end

function hero.draw()
    love.graphics.draw(
        hero.tileSheet, hero.directionTexture[hero.direction], 
        hero.x * settings.TILE_SIZE, hero.y * settings.TILE_SIZE
    )
end

return hero
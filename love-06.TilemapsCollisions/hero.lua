local hero = {}

local settings = require("settings")

function hero.load()
    hero.tileSheet = love.graphics.newImage("assets/knight.png")
    hero.directionTexture = {
        {}, {}, {}, {}
    }
    local i, j
    for i = 1, 4 do
        for j = 1, 4 do
            hero.directionTexture[i][j] = love.graphics.newQuad(
                (j-1) * settings.TILE_SIZE, (i-1) * settings.TILE_SIZE, 
                settings.TILE_SIZE, settings.TILE_SIZE, 
                hero.tileSheet:getWidth(), hero.tileSheet:getHeight()
            )
        end
    end
    
    hero.direction = 1
    hero.anim = 1
    hero.x = 3
    hero.y = 3
    hero.isMoving = true
end

function hero.update(dt)
    if hero.isMoving then
        hero.anim = hero.anim + settings.ANIM_SPEED * dt
        if hero.anim >= 5 then
            hero.anim = 1
        end
    else
        hero.anim = 1
    end
end

function hero.draw()
    love.graphics.draw(
        hero.tileSheet, hero.directionTexture[hero.direction][math.floor(hero.anim)], 
        hero.x * settings.TILE_SIZE, hero.y * settings.TILE_SIZE
    )
end

return hero
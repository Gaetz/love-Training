local hero = {}

local settings = require("settings")

function hero.load(map)
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
    hero.targetX = 3
    hero.targetY = 3
    hero.isMoving = false
    hero.speed = 3

    map.clearFogAura(hero.x, hero.y)
end

function hero.update(dt, map)
    -- input
    if not hero.isMoving then
        if (love.keyboard.isDown("left") and hero.x > 0 ) then
            hero.targetX = hero.x - 1
            hero.direction = 2
            hero.isMoving = true
        end
        if (love.keyboard.isDown("right") and hero.x < settings.MAP_WIDTH - 1) then
            hero.targetX = hero.x + 1
            hero.direction = 3
            hero.isMoving = true
        end
        if (love.keyboard.isDown("down") and hero.y < settings.MAP_HEIGHT - 1) then
            hero.targetY = hero.y + 1
            hero.direction = 1
            hero.isMoving = true
        end
        if (love.keyboard.isDown("up") and hero.y > 0) then
            hero.targetY = hero.y - 1
            hero.direction = 4
            hero.isMoving = true
        end
        -- collision cancel move
        if map.isSolid(hero.targetX, hero.targetY) then
            hero.targetX = hero.x
            hero.targetY = hero.y
            hero.isMoving = false
        end
    -- move
    else
        if hero.x < hero.targetX then
            hero.x = hero.x + hero.speed * dt
            if math.floor(hero.x) == hero.targetX then
                hero.endMove(map)
            end
        end
        if hero.x > hero.targetX then
            hero.x = hero.x - hero.speed * dt
            if math.ceil(hero.x) == hero.targetX then
                hero.endMove(map)
            end
        end
        if hero.y < hero.targetY then
            hero.y = hero.y + hero.speed * dt
            if math.floor(hero.y) == hero.targetY then
                hero.endMove(map)
            end
        end
        if hero.y > hero.targetY then
            hero.y = hero.y - hero.speed * dt
            if math.ceil(hero.y) == hero.targetY then
                hero.endMove(map)
            end
        end
    end
    
    -- animation
    if hero.isMoving then
        hero.anim = hero.anim + settings.ANIM_SPEED * dt
        if hero.anim >= #hero.directionTexture[hero.direction] + 1 then
            hero.anim = 1
        end
    else
        hero.anim = 1
    end
end

function hero.endMove(map)
    hero.x = hero.targetX
    hero.y = hero.targetY
    hero.isMoving = false
    map.clearFogAura(hero.x, hero.y)
end

function hero.draw()
    love.graphics.draw(
        hero.tileSheet, hero.directionTexture[hero.direction][math.floor(hero.anim)], 
        hero.x * settings.TILE_SIZE, hero.y * settings.TILE_SIZE
    )
end

return hero
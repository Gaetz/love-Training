local aliens = {}
local settings = require("settings")

    aliens.list = {}

    function aliens.create(type, row, col)
        local alien = {}
        -- Data in function of type
        local image = "assets/caca.png"
        local vx = 0
        local vy = 0.6
        if type == "cacarose" then
            image = "assets/cacarose.png"
            vx = 1
            local direction = love.math.random(1, 2)
            if direction == 2 then
                vx = -1
            end 
        end
        -- Data
        alien.image = love.graphics.newImage(image)
        alien.x = col * settings.TILE_SIZE
        alien.y = - row * settings.TILE_SIZE / 2 - (row - 1) * settings.TILE_SIZE
        alien.vx = vx
        alien.vy = vy
        alien.delete = false
        alien.sleeping = true
        alien.w = alien.image:getWidth()
        alien.h = alien.image:getHeight()
        table.insert(aliens.list, alien)
    end

    function aliens.update(dt)
        -- Logic
        for i=1,#aliens.list do
            local alien = aliens.list[i]
            if alien.sleeping then
                alien.y = alien.y + settings.MAP_SPEED
            else
                alien.x = alien.x + alien.vx
                alien.y = alien.y + alien.vy
            end
            if alien.y > settings.GAME_HEIGHT then
                alien.delete = true
            end
            -- cacarose bounce
            if (alien.x <= 0 or alien.x >= settings.GAME_WIDTH) then
                alien.vx = -alien.vx
            end
        end
        -- Deletion
        for i=#aliens.list, 1, -1 do
            local alien = aliens.list[i]
            if alien.delete then
                table.remove(aliens.list, i)
            end
        end
    end

    function aliens.draw()
        for i=1,#aliens.list do
            local alien = aliens.list[i]
            love.graphics.draw(alien.image, alien.x, alien.y)
        end
    end

return aliens
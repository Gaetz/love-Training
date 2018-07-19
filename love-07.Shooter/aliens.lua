local aliens = {}
local settings = require("settings")

    aliens.list = {}

    function aliens.create(type, x, y)
        local alien = {}
        -- Data in function of type
        local image = "assets/caca.png"
        local sx = 0
        local sy = 2
        if type == "cacarose" then
            image = "assets/cacarose.png"
            sx = 1
            local direction = love.math.random(1, 2)
            if direction == 2 then
                sx = -1
            end 
        end
        -- Data
        alien.image = love.graphics.newImage(image)
        alien.x = x
        alien.y = y
        alien.sx = sx
        alien.sy = sy
        alien.delete = false
        alien.w = alien.image:getWidth()
        alien.h = alien.image:getHeight()
        table.insert(aliens.list, alien)
    end

    function aliens.update(dt)
        -- Logic
        for i=1,#aliens.list do
            local alien = aliens.list[i]
            alien.x = alien.x + alien.sx
            alien.y = alien.y + alien.sy
            if alien.y > settings.GAME_HEIGHT then
                alien.delete = true
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
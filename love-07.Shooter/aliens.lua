local aliens = {}
local settings = require("settings")
local shots = require("shots")

    aliens.list = {}
    hitSound = love.audio.newSource("assets/explode.wav", "static")

    function aliens.generate()
        aliens.create("cacarouge", 11, 2)
        aliens.create("cacarouge", 13, 9)

        aliens.create("caca", 20, 1)
        aliens.create("caca", 19, 3)
        aliens.create("cacarose", 18, 5)
        aliens.create("caca", 19, 7)
        aliens.create("caca", 20, 9)

        aliens.create("cacarouge", 23, 2)
        aliens.create("cacarouge", 25, 9)

        aliens.create("caca", 32, 1)
        aliens.create("caca", 31, 3)
        aliens.create("cacarose", 30, 5)
        aliens.create("caca", 31, 7)
        aliens.create("caca", 32, 9)

        aliens.create("cacarouge", 35, 2)
        aliens.create("cacarouge", 37, 9)
    end

    function aliens.create(type, row, col)
        local alien = {}
        -- Data in function of type
        local image = "assets/caca.png"
        local vx = 0
        local vy = settings.ENEMY_Y_SPEED
        local life = 1
        if type == "cacarose" then
            image = "assets/cacarose.png"
            vx = settings.ENEMY_X_SPEED
            local direction = love.math.random(1, 2)
            if direction == 2 then
                vx = -settings.ENEMY_X_SPEED
            end
            life = 2
        end
        if type == "cacarouge" then
            image = "assets/cacarouge.png"
            vy = settings.MAP_SPEED
            life = 3
        end
        -- Data
        alien.image = love.graphics.newImage(image)
        alien.x = (col - 0.25) * settings.TILE_SIZE
        alien.y = (- row + settings.MAP_HEIGHT - 0.5) * settings.TILE_SIZE
        alien.vx = vx
        alien.vy = vy
        alien.delete = false
        alien.sleeping = true
        alien.w = alien.image:getWidth()
        alien.h = alien.image:getHeight()
        alien.type = type
        alien.life = life
        alien.counter = 0
        table.insert(aliens.list, alien)
    end

    function aliens.update(player, dt)
        -- Logic
        for i=1,#aliens.list do
            local alien = aliens.list[i]
            -- Sleeping management
            if alien.y + alien.image:getHeight() > 0 then
                alien.sleeping = false
            end
            -- Behaviour
            if alien.sleeping then
                alien.y = alien.y + settings.MAP_SPEED * dt
            else
                alien.x = alien.x + alien.vx * dt
                alien.y = alien.y + alien.vy * dt
                -- cacarose bounce
                if alien.type == "cacarose" then
                    if (alien.x <= 0 or alien.x >= settings.GAME_WIDTH) then
                        alien.vx = -alien.vx
                    end
                end
                -- Alien shoots
                alien.counter = alien.counter + 1
                if alien.type == "cacarouge" then
                    if alien.counter >= 100 then
                        alien.counter = 0
                        local angle = math.angle(alien.x, alien.y, player.x, player.y)
                        local vx = math.cos(angle) * 90
                        local vy =  math.sin(angle) * 90
                        shots.create(alien, false, true, vx, vy)
                      end
                else
                    if alien.counter >= 200 then
                        alien.counter = 0
                        shots.create(alien, false, false)
                    end
                end
            end
            if alien.y > settings.GAME_HEIGHT then
                alien.delete = true
            end
            if alien.life <= 0 then
                aliens.destroy(i)
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

    function aliens.hit(i)
        local alien = aliens.list[i]
        alien.life = alien.life - 1
        hitSound:setPitch(2.0)
        hitSound:play()
    end

    function aliens.destroy(i)
        local alien = aliens.list[i]
        alien.delete = true
    end

    function aliens.draw()
        for i=1,#aliens.list do
            local alien = aliens.list[i]
            love.graphics.draw(alien.image, alien.x, alien.y)
        end
    end

return aliens
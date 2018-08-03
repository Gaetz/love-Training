local explosions = {}
local settings = require("settings")

    explosions.list = {}

    function explosions.load()
        explosions.explosionImages = {}
        for i=1, 5 do
            explosions.explosionImages[i] = love.graphics.newImage("assets/explode_"..i..".png")
        end
    end

    function explosions.create(x, y, vx, vy)
        local explosion = {}
        explosion.x = x
        explosion.y = y
        explosion.vx = vx
        explosion.vy = vy
        explosion.frame = 1
        explosion.counter = 0
        explosion.maxFrame = 5
        explosion.delete = false
        table.insert(explosions.list, explosion)
    end

    function explosions.createBig(x, y, vx, vy)
        for i=1, 5 do
            local explosion = {}
            explosion.x = x + math.random(-10, 10)
            explosion.y = y + math.random(-10, 10)
            explosion.vx = vx
            explosion.vy = vy
            explosion.frame = 1
            explosion.counter = 0
            explosion.maxFrame = 5
            explosion.delete = false
            table.insert(explosions.list, explosion)
        end
    end

    function explosions.update(dt)
        -- Explosion animation
        for i= 1, #explosions.list do
            local explosion = explosions.list[i]
            explosion.x = explosion.x + explosion.vx * dt
            explosion.y = explosion.y + explosion.vy * dt
    
            explosion.counter = explosion.counter + 1
            if explosion.counter > 10 then
                if explosion.frame < explosion.maxFrame then
                    explosion.frame = explosion.frame + 1
                    explosion.counter = 0
                else 
                    explosion.delete = true
                end
            end
        end
        -- Explosion deletion
        for i= #explosions.list, 1, -1 do
            local explosion = explosions.list[i]
            if explosion.delete then
                explosion.image = nil
                table.remove(explosions.list, i)
            end
        end
    end

    function explosions.draw()
        for i=1,#explosions.list do
            local explosion = explosions.list[i]
            love.graphics.draw(
                explosions.explosionImages[explosion.frame], 
                explosion.x, explosion.y
            )
        end
        
    end

return explosions
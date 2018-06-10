local shots = {}
local settings = require("settings")

    shots.list = {}

    function shots.create(player)
        local shot = {}
        shot.image = love.graphics.newImage("assets/shoot.png")
        shot.x = player.x + player.image:getWidth() / 2 - shot.image:getWidth() / 2
        shot.y = player.y
        shot.speed = settings.SHOT_SPEED
        table.insert(shots.list, shot)
    end

    function shots.update(dt)
        for i=1,#shots.list do
            local shot = shots.list[i]
            shot.y = shot.y + shot.speed * dt
        end
    end

    function shots.draw()
        for i=1,#shots.list do
            local shot = shots.list[i]
            love.graphics.draw(shot.image, shot.x, shot.y)
        end
        
    end

return shots
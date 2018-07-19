local shots = {}
local settings = require("settings")

    shots.list = {}
    sound = love.audio.newSource("assets/shoot.wav", "static")

    function shots.create(player)
        local shot = {}
        shot.image = love.graphics.newImage("assets/shoot.png")
        shot.x = player.x + player.image:getWidth() / 2 - shot.image:getWidth() / 2
        shot.y = player.y
        shot.speed = settings.SHOT_SPEED
        table.insert(shots.list, shot)
        love.audio.play(sound)
    end

    function shots.update(dt)
        for i=#shots.list,1,-1 do
            local shot = shots.list[i]
            shot.y = shot.y + shot.speed * dt
            if shot.y < 0 - shot.image:getHeight() then
                shot.image = nil
                table.remove(shots.list, i)
            end
        end
    end

    function shots.draw()
        for i=1,#shots.list do
            local shot = shots.list[i]
            love.graphics.draw(shot.image, shot.x, shot.y)
        end
        
    end

return shots
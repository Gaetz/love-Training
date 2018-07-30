local shots = {}
local settings = require("settings")

    shots.list = {}
    sound = love.audio.newSource("assets/shoot.wav", "static")

    function shots.create(source, fromPlayer)
        local shot = {}
        shot.image = love.graphics.newImage("assets/shoot.png")
        shot.x = source.x + source.image:getWidth() / 2 - shot.image:getWidth() / 2
        if fromPlayer then
            shot.y = source.y
            shot.speed = settings.SHOT_SPEED
        else
            shot.y = source.y + source.image:getHeight() / 2
            shot.speed = -settings.SHOT_SPEED / 2
        end
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
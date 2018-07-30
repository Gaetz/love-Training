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
        shot.fromPlayer = fromPlayer
        shot.delete = false
        table.insert(shots.list, shot)
        sound:play()
    end

    function shots.update(player, aliens, dt)
        for i= 1, #shots.list do
            local shot = shots.list[i]
            -- Shoot interaction
            if shot.fromPlayer then
                for j= 1, #aliens.list do
                    local alien = aliens.list[j]
                    if collide(shot, alien) then
                        shot.delete = true
                        aliens.hit(j)
                    end
                end
            else
                if collide(shot, player) then
                    shot.delete = true
                end
            end
            -- Shoot management
            shot.y = shot.y + shot.speed * dt
            if shot.y < 0 - shot.image:getHeight() 
            or shot.y > settings.GAME_HEIGHT then
                shot.delete = true
            end
        end
        -- Shoot deletion
        for i= #shots.list, 1, -1 do
            local shot = shots.list[i]
            if shot.delete then
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
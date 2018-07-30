local player = {}
local settings = require("settings")


function player.load()
    player.image = love.graphics.newImage("assets/ship.png")
    player.x = settings.GAME_WIDTH / 2
    player.y = settings.GAME_HEIGHT - player.image:getHeight()
    player.speed = settings.PLAYER_SPEED
end

function player.update(dt)
    -- Move
    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed * dt
    end
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed * dt
    end
    player.x = clamp(0, player.x, settings.GAME_WIDTH - player.image:getWidth())
end

function player.draw()
    love.graphics.draw(player.image, player.x, player.y)
end

return player
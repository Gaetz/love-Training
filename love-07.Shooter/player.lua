local player = {}

function player.load()
    player.image = love.graphics.newImage("assets/ship.png")
    player.x = 100
    player.y = 200
end

function player.draw()
    love.graphics.draw(player.image, player.x, player.y)
end

return player
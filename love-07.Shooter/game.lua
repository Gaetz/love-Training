local game = {}
local settings = require("settings")

game.player = require("player")
game.shots = require("shots")
game.aliens = require("aliens")

function game.load()
    game.player.load()
    game.aliens.create("caca", 40, 20)
    game.aliens.create("caca", 120, 60)
    game.aliens.create("cacarose", 200, 100)
    game.aliens.create("caca", 280, 60)
    game.aliens.create("caca", 360, 20)
end

function game.update(dt)
    game.player.update(dt)
    game.shots.update(dt)
    game.aliens.update(dt)
end

function game.draw()
    game.player.draw()
    game.shots.draw()
    game.aliens.draw()
end

function game.drawDebug()
    love.graphics.print({ { 0, 0, 1, 1} , #game.shots.list }, 0, 0)
end

function love.keypressed(key)
    if key == "space" then
        game.shots.create(game.player)
    end
end


return game
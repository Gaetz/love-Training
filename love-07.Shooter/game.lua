local game = {}
local settings = require("settings")

game.player = require("player")
game.shots = require("shots")
game.aliens = require("aliens")
game.map = require("map")

function game.load()
    game.player.load()
    game.aliens.create("caca", 20, 20)
    game.aliens.create("caca", 60, 60)
    game.aliens.create("cacarose", 100, 100)
    game.aliens.create("caca", 140, 60)
    game.aliens.create("caca", 180, 20)
    game.map.load()
end

function game.update(dt)
    game.map.update(dt)
    game.player.update(dt)
    game.shots.update(dt)
    game.aliens.update(dt)
end

function game.draw()
    game.map.draw()
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
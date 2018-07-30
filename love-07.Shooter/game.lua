local game = {}
local settings = require("settings")

game.player = require("player")
game.shots = require("shots")
game.aliens = require("aliens")
game.map = require("map")

function game.load()
    game.player.load()
    game.aliens.generate()
    game.map.load()
end

function game.update(dt)
    game.map.update(dt)
    game.shots.update(game.player, game.aliens, dt)
    game.player.update(dt)
    game.aliens.update(game.player, dt)
end

function game.draw()
    game.map.draw()
    game.player.draw()
    game.aliens.draw()
    game.shots.draw()
end

function game.drawDebug()
    love.graphics.print({ { 0, 0, 1, 1} , #game.shots.list }, 0, 0)
end

function love.keypressed(key)
    if key == "space" then
        game.shots.create(game.player, true)
    end
end


return game
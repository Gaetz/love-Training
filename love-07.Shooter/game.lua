local game = {}
local settings = require("settings")

game.player = require("player")
game.shots = require("shots")

function game.load()
    game.player.load()
end

function game.update(dt)
    game.player.update(dt)
    game.shots.update(dt)
end

function game.draw()
    game.player.draw()
    game.shots.draw()
end

function game.drawDebug()

end

function love.keypressed(key)
    if key == "space" then
        game.shots.create(game.player)
    end
end


return game
local game = {}
local settings = require("settings")

game.player = require("player")

function game.load()
    game.player.load()
end

function game.update(dt)

end

function game.draw()
    game.player.draw()
end

function game.drawDebug()

end

return game
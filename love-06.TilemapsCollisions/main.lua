local windowWidth, windowHeight
local game = require("game")

function love.load()
    windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.setDefaultFilter("nearest")

    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(5, 5)

    -- Draw with scaling
    game.draw()
    
    love.graphics.pop()

    -- Draw without scaling
    game.drawDebug()
end
local windowWidth, windowHeight
local game = require("game")
local settings = require("settings")

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
    love.graphics.scale(settings.SCALE, settings.SCALE)

    -- Draw with scaling
    game.draw()
    
    love.graphics.pop()

    -- Draw without scaling
    game.drawDebug()
end
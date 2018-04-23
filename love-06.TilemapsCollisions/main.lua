local windowWidth, windowHeight
local game = require("game")
local settings = require("settings")
-- add dist in math 
function math.dist(x1, y1, x2, y2) return ((x2-x1)^2 + (y2-y1)^2)^0.5 end

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
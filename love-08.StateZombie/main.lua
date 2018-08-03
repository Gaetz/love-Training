local windowWidth, windowHeight
local game = require("game")
local settings = require("settings")

function love.load()
    love.graphics.setDefaultFilter("nearest")
    love.math.setRandomSeed(love.timer.getTime())
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

function math.clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function math.dist(x1, y1, x2, y2) return ((x2-x1)^2 + (y2-y1)^2)^0.5 end

function collide(a, b)
    if a == b then
        return false
    end
    local test = (a.x + a.image:getWidth() < b.x) 
        or (b.x + b.image:getWidth() < a.x) 
        or (a.y + a.image:getHeight() < b.y) 
        or (b.y + b.image:getHeight() < a.y)
    return not test
end
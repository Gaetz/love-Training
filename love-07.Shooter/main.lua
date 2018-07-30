local windowWidth, windowHeight
local game = require("game")
local settings = require("settings")
-- add dist in math 
function math.dist(x1, y1, x2, y2) return ((x2-x1)^2 + (y2-y1)^2)^0.5 end

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

function clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

function collide(a1, a2)
    if a1 == a2 then
        return false
    end
    local dx = a1.x - a2.x
    local dy = a1.y - a2.y
    if math.abs(dx) < a1.image:getWidth() + a2.image.getWidth() then
        if math.abs(dy) < a1.image:getHeight() + a2.image.getHeight() then
            return true
        end
    end
    return false
end
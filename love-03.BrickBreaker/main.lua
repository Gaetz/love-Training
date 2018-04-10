local img
local windowWidth, windowHeight
local pad
local ball
local brick
local level

local numberOfRows = 6
local numberOfCols = 15

function love.load()
    windowWidth, windowHeight = love.graphics.getWidth(), love.graphics.getHeight()
    -- pad
    pad = {}
    pad.width = 120
    pad.height = 20
    pad.x = windowWidth / 2 - pad.width / 2
    pad.y = windowHeight - pad.height
    -- ball
    ball = {}
    ball.x = 100
    ball.y = 100
    ball.radius = 10
    -- bricks
    brick = {}
    brick.height = 20
    brick.width = windowWidth / 15
    -- init
    reset()
end

function reset()
    -- reset ball
    ball.sticky = true
    ball.vx = 400
    ball.vy = -400
    -- reset level    
    level = {}
    local row, col
    for row = 0, numberOfRows-1 do
        level[row] = {}
        for col = 0, numberOfCols-1 do
            level[row][col] = 1
        end
    end
end

function love.update(dt)
    -- pad
    pad.x = love.mouse.getX()
    -- pad limits
    if(pad.x >= windowWidth - pad.width / 2) then
        pad.x = windowWidth - pad.width / 2
    end
    if(pad.x <= pad.width / 2) then
        pad.x = pad.width / 2
    end
    -- ball
    if ball.sticky then
        ball.x = pad.x
        ball.y = pad.y - ball.radius
    else
        ball.x = ball.x + ball.vx * dt
        ball.y = ball.y + ball.vy * dt
    end
    -- ball limits
    if ball.x < ball.radius then
        ball.vx = -ball.vx
        ball.x = ball.radius
    end
    if ball.x > windowWidth - ball.radius then
        ball.vx = -ball.vx
        ball.x = windowWidth - ball.radius
    end
    if (ball.y < ball.radius) then
        ball.vy = - ball.vy
        ball.y = ball.radius
    end
    -- restart game if ball go out of bounds
    if (ball.y > windowHeight) then
        reset()
    end
    -- pad / ball collision
    if ball.y > pad.y - ball.radius then
        if math.abs(ball.x - pad.x) <= pad.width / 2 then
            ball.vy = - ball.vy
            ball.y = pad.y - ball.radius
        end
    end
    -- brick / ball collision
    local col = math.floor(ball.x / brick.width)
    local row = math.floor(ball.y / brick.height)
    if row >=0 and row <= numberOfRows-1 and col >= 0 and row <= numberOfCols-1 then
        if level[row][col] == 1 then
            level[row][col] = 0
            ball.vy = - ball.vy
        end
    end
end

function love.mousepressed(x, y, n)
    if ball.sticky then
        ball.sticky = false
    end
end

function love.draw()
    -- pad and ball
    love.graphics.rectangle("fill", pad.x - pad.width / 2, pad.y, pad.width, pad.height)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    -- bricks
    for row = 0,5 do
        for col = 0, 14 do
            if level[row][col] == 1 then
                love.graphics.rectangle("fill", col * brick.width + 1, row * brick.height + 1, brick.width - 2, brick.height - 2)
            end
        end
    end
end
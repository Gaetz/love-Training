local lander, fire
local gravity = 0.8
local startAngle = 270
local maxSpeed = 1
local groundHeight = 50

local landMaxSpeed = 0.5
local landMaxAngle = 5
local result = 0

function love.load()
    lander = {}
    lander.x = love.graphics:getWidth() / 2
    lander.y = love.graphics:getHeight() / 2
    lander.angle = startAngle
    lander.vx = 0
    lander.vy = 0
    lander.img = love.graphics.newImage("assets/images/lander.png")
    lander.speed = 3

    fire = {}
    fire.img = love.graphics.newImage("assets/images/lander-fire.png")
    fire.display = false
end

function love.update(dt)
    if result == 0 then
        -- Victory condition
        if lander.y + lander.img:getHeight() / 2 > love.graphics:getHeight() - groundHeight then 
            if (lander.vy <= landMaxSpeed 
            and (lander.angle - startAngle) % 360 >= -landMaxAngle 
            and (lander.angle - startAngle) % 360 <= landMaxAngle) then
                result = 2
            else 
                result = 1
            end
        end

        -- input
        if love.keyboard.isDown("up") then
            fire.display = true

            local angleRadian = math.rad(lander.angle) 
            local xForce = math.cos(angleRadian) * lander.speed * dt
            local yForce = math.sin(angleRadian) * lander.speed * dt
            lander.vx = lander.vx + xForce
            lander.vy = lander.vy + yForce
        else
            fire.display = false
        end

        if love.keyboard.isDown("left") then
            lander.angle = lander.angle - 90 * dt
            if lander.angle < 0 then 
                lander.angle = lander.angle % 360
            end
        end
        if love.keyboard.isDown("right") then
            lander.angle = lander.angle + 90 * dt
            if lander.angle > 360 then 
                lander.angle = lander.angle % 360 
            end
        end

        -- cap speed
        if lander.vx > maxSpeed then lander.vx = maxSpeed end
        if lander.vx < -maxSpeed then lander.vx = -maxSpeed end
        if lander.vy < -maxSpeed then lander.vy = -maxSpeed end

        -- gravity
        lander.vy = lander.vy + gravity * dt
        -- move
        lander.x = lander.x + lander.vx
        lander.y = lander.y + lander.vy
    end
end

function love.draw()
    if result == 0 or result == 2 then
        -- lander
        love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle - startAngle), 1, 1, lander.img:getWidth() / 2, lander.img:getHeight() / 2)
        if fire.display then
            love.graphics.draw(fire.img, lander.x, lander.y, math.rad(lander.angle - startAngle), 1, 1, fire.img:getWidth() / 2, fire.img:getHeight() / 2)
        end
        -- ground
        love.graphics.rectangle("fill", 0, love.graphics:getHeight() - groundHeight, love.graphics:getWidth(), groundHeight)

        if result == 2 then
            love.graphics.print("You win", love.graphics:getWidth() / 2, love.graphics:getHeight() / 2)
        end
    elseif result == 1 then
        love.graphics.print("You lose", love.graphics:getWidth() / 2, love.graphics:getHeight() / 2)
    end

    -- debug
    love.graphics.print("Angle: "..((lander.angle - startAngle) % 360).." vx: "..lander.vx.." vy: "..lander.vy, 0, 0)
end

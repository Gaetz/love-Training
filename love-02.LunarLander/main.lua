local lander, fire
local gravity = 0.8

function love.load()
    lander = {}
    lander.x = love.graphics:getWidth() / 2
    lander.y = love.graphics:getHeight() / 2
    lander.angle = 0
    lander.vx = 0
    lander.vy = 0
    lander.img = love.graphics.newImage("assets/images/lander.png")

    fire = {}
    fire.img = love.graphics.newImage("assets/images/lander-fire.png")
    fire.display = false
end

function love.update(dt)
    -- gravity
    lander.vy = lander.vy + gravity * dt
    -- move
    lander.x = lander.x + lander.vx
    lander.y = lander.y + lander.vy

    -- input
    if love.keyboard.isDown("up") then
        fire.display = true
    else
        fire.display = false
    end
    if love.keyboard.isDown("left") then
        lander.angle = lander.angle - 90 * dt
    end
    if love.keyboard.isDown("right") then
        lander.angle = lander.angle + 90 * dt
    end
end

function love.draw()
    love.graphics.draw(lander.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, lander.img:getWidth() / 2, lander.img:getHeight() / 2)
    if fire.display then
        love.graphics.draw(fire.img, lander.x, lander.y, math.rad(lander.angle), 1, 1, fire.img:getWidth() / 2, fire.img:getHeight() / 2)
    end
end
local img
local imgCross
local x, y = 0, 0
local ox, oy = 0, 0
local rotation = 0
local scale = 1
local isScaleAnimated = false
local animScale = -0.01
local font = love.graphics.newFont(14)

function love.load()
    img = love.graphics.newImage("assets/images/mushroom.png")
    imgCross = love.graphics.newImage("assets/images/cross.png")
    x = love.graphics:getWidth() / 2
    y = love.graphics:getHeight() / 2
    ox = 0
    oy = 0
end

function love.update(dt)
    if bAnimScale then
        scale = scale + animScale
        if scale <= 0.5 then
            scale = 0.5
            animScale = 0 - animScale
        end
        if scale >= 1 then
            scale = 1
            animScale = 0 - animScale
        end
    end

    local shift = love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")
    local ctrl = love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")

    if love.keyboard.isDown("right") and ctrl == true and shift == false then
        rotation = rotation + 0.01
    end
    if love.keyboard.isDown("left") and ctrl == true and shift == false then
        rotation = rotation - 0.01
    end

    if love.keyboard.isDown("right") and shift and ctrl == false then
        ox = ox + 1
    end
    if love.keyboard.isDown("left") and shift and ctrl == false then
        ox = ox - 1
    end
    if love.keyboard.isDown("up") and shift and ctrl == false then
        oy = oy - 1
    end
    if love.keyboard.isDown("down") and shift and ctrl == false then
        oy = oy + 1
    end

    if love.keyboard.isDown("right") and shift == false and ctrl == false then
        x = x + 1
    end
    if love.keyboard.isDown("left") and shift == false and ctrl == false then
        x = x - 1
    end
    if love.keyboard.isDown("up") and shift == false and ctrl == false then
        y = y - 1
    end
    if love.keyboard.isDown("down") and shift == false and ctrl == false then
        y = y + 1
    end
end

function love.draw()
    -- Debug
    love.graphics.print(
        "x=" .. tostring(x) .. " |  y=" .. tostring(y) .. " | " .. "ox=" .. tostring(ox) .. " | oy=" .. tostring(oy),
        0,
        0
    )
    love.graphics.print(
        "c=centrer origine | v=reset origine | r=reset rotation | a=Animer scaling",
        0,
        font:getHeight("X")
    )
    love.graphics.print(
        "flèches=changer x,y | shift+flèches=changer origine | ctrl+flèches=rotation",
        0,
        font:getHeight("X") * 2
    )
    love.graphics.print("Images ", 0, love.graphics:getHeight() - font:getHeight("X"))

    love.graphics.draw(img, x, y, rotation, scale, scale, ox, oy)
    love.graphics.draw(imgCross, x, y, 0, 1, 1, 8, 8)

    local sox, soy = tostring(ox), tostring(oy)
    love.graphics.print(ox, x - font:getWidth(sox) / 2, y - 25)
    love.graphics.print(oy, x - font:getWidth(soy) - 10, y - font:getHeight(soy) / 2)
end

function love.keypressed(key)
    if key == "a" then
        scale = 1
        if bAnimScale == false then
            bAnimScale = true
        else
            bAnimScale = false
        end
    end

    if key == "c" then
        ox = img:getWidth() / 2
        oy = img:getHeight() / 2
    end
    if key == "v" then
        ox = 0
        oy = 0
    end
    if key == "r" then
        rotation = 0
    end
end

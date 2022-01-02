Snake = {
    Position = {0.5, 0.5},
    Direction = 0, -- 0 Right, 1 Down, 2 Left, 3 Up
    Speed = 50
}

function UpdateXs(val)
    local newPosition = {}
    for k, v in ipairs(Snake.Position) do
        -- Xs are odd
        if k % 2 ~= 0 then
            v = (v + val) % love.graphics.getWidth()
        end

        table.insert(newPosition, v)
    end
    Snake.Position = newPosition
end

function UpdateYs(val)
    local newPosition = {}
    for k, v in ipairs(Snake.Position) do
        -- Ys are even
        if k % 2 == 0 then
            v = (v + val) % love.graphics.getHeight()
        end
        table.insert(newPosition, v)
    end
    Snake.Position = newPosition
end

function UpdateSnake(dt)
    local val = Snake.Speed * dt
    if Snake.Direction > 1 then
        val = -val
    end
    if Snake.Direction % 2 == 0 then
        UpdateXs(val)
    else
        UpdateYs(val)
    end
end

function love.draw()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.points(Snake.Position)
end

function love.update(dt)
    UpdateSnake(dt)

end

function love.load()
end

function love.quit()
end

function love.keypressed(key)
    print(key .. "")
    if (key == "up") then
        Snake.Direction = 3
    elseif key == "right" then
        Snake.Direction = 0
    elseif key == "down" then
        Snake.Direction = 1
    elseif key == "left" then
        Snake.Direction = 2
    else
        print(key)
    end
end

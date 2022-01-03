require("globals")
require("snake")

Food = {}

Screen = {
    Mid = {love.graphics.getWidth() / 2 - 0.5, love.graphics.getHeight() / 2 - 0.5},
    Width = 768,
    Height = 512,
    CellSize = 8
}

Game = {
    XCells = Screen.Width / Screen.CellSize,
    YCells = Screen.Height / Screen.CellSize,
    Score = 0
}

function MakeFood(idx)
    Food[idx] = {math.floor((math.random() * Game.XCells)), math.floor((math.random() * Game.YCells))}
end

function love.draw()
    love.graphics.setColor(0, 255, 0, 255)
    for k, v in pairs(Snake.Position) do
        local x = v[1] * Screen.CellSize + (Screen.Mid[1] - Screen.Width / 2)
        local y = v[2] * Screen.CellSize + (Screen.Mid[2] - Screen.Height / 2)
        love.graphics.polygon("fill", {x, y, x + Screen.CellSize, y, x + Screen.CellSize, y + Screen.CellSize, x,
                                       y + Screen.CellSize})
    end
    -- Draw food
    love.graphics.setColor(255, 0, 0, 255)
    for k, v in pairs(Food) do
        local x = v[1] * Screen.CellSize + (Screen.Mid[1] - Screen.Width / 2)
        local y = v[2] * Screen.CellSize + (Screen.Mid[2] - Screen.Height / 2)
        love.graphics.polygon("fill",
                              {x + Screen.CellSize / 2, y, x + Screen.CellSize, y + Screen.CellSize / 2,
                               x + Screen.CellSize / 2, y + Screen.CellSize, x, y + Screen.CellSize / 2})
    end

    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)

    love.graphics.print("Score: " .. Game.Score, 10, 10)
end

function love.update(dt)
    UpdateSnake(dt)

    -- Check Collision
    for k, v in pairs(Food) do
        if (Snake.Position[1][1] == v[1] and Snake.Position[1][2] == v[2]) then
            GrowSnake()
            MakeFood(k)
        end
    end
    -- print(SnakeLength())
end

function love.load()
    InitSnake()
    math.randomseed(os.time())
    for i = 1, 100 do
        MakeFood(i)
    end
end

function love.quit()
end

function love.keypressed(key)
    print(key .. "")
    if (key == "up") and Snake.Direction ~= "down" then
        Snake.Direction = "up"
    elseif key == "right" and Snake.Direction ~= "left" then
        Snake.Direction = "right"
    elseif key == "down" and Snake.Direction ~= "up" then
        Snake.Direction = "down"
    elseif key == "left" and Snake.Direction ~= "right" then
        Snake.Direction = "left"
    else
        print(key)
    end
end

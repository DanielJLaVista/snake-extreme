require("snake")

DefaultGame = {
    Snakes = {},
    Food = {}
}

Game = DefaultGame

function Update(dt)
    Game.Snakes[1]:update()
    CheckCollision(Game.Snakes[1])
end

function CheckCollision(Snake)
    -- Check Collision
    for k, v in pairs(Game.Food) do
        if (Snake.Position[1][1] == v[1] and Snake.Position[1][2] == v[2]) then
            Game.Snakes[1]:growSnake()
            MakeFood(k)
        end
    end
    for k, v in pairs(Snake.Position) do
        if (Snake.Position[1][1] == v[1] and Snake.Position[1][2] == v[2]) and k ~= 1 then
            Reset()
        end
    end
end

function Reset()

    Game = DefaultGame
    table.insert(Game.Snakes, Snake:new())
    for i = 1, 10 do
        MakeFood(nil)
    end
end

function MakeFood(idx)
    local val = {math.floor((math.random() * Board.XCells)), math.floor((math.random() * Board.YCells))}
    if (idx == nil) then
        table.insert(Game.Food, val)
    else
        Game.Food[idx] = val
    end
end

function DrawGame()
    Game.Snakes[1]:drawSnake()

    -- Draw food
    love.graphics.setColor(255, 0, 0, 255)
    for k, v in pairs(Game.Food) do
        local x = v[1] * Screen.CellSize + (Screen.Mid[1] - Screen.Width / 2)
        local y = v[2] * Screen.CellSize + (Screen.Mid[2] - Screen.Height / 2)
        love.graphics.polygon("fill",
                              {x + Screen.CellSize / 2, y, x + Screen.CellSize, y + Screen.CellSize / 2,
                               x + Screen.CellSize / 2, y + Screen.CellSize, x, y + Screen.CellSize / 2})
    end
end

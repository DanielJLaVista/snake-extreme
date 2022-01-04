require("globals")

function UpdateSnake(Snake)
    -- Move Snake
    local newPosition = {}
    if Snake.FrameCount % (100 / Snake.Speed) == 0 then
        -- Update tail
        local newTail = nil
        if (Snake.Grow > 0) then
            newTail = Snake.Position[#Snake.Position]
            Snake.Grow = Snake.Grow - 1
        end
        for i = #(Snake.Position), 2, -1 do
            newPosition[i] = Snake.Position[i - 1]
        end
        if newTail ~= nil then
            table.insert(newPosition, newTail)
        end
        -- Update head
        newPosition[1] = {(Snake.Position[1][1] + Directions[Snake.Direction][1]) % Board.XCells,
                          (Snake.Position[1][2] + Directions[Snake.Direction][2]) % Board.YCells}

        Snake.Position = newPosition
    end

    Snake.FrameCount = Snake.FrameCount + 1
    return Snake
end

function GrowSnake(Snake)
    Snake.Grow = Snake.Grow + 1
    Snake.Score = Snake.Score + 1
    return Snake
end

local function initPosition(Snake, length)
    local newPosition = {}
    local head = {Board.XCells / 2, Board.YCells / 2}
    table.insert(newPosition, head)

    for i = 1, length do
        local point = {0, 0}
        point[1] = (newPosition[#newPosition][1] + 1) % Board.XCells
        point[2] = newPosition[#newPosition][2]

        table.insert(newPosition, point)
    end
    Snake.Position = newPosition

    return Snake
end

function InitSnake()
    Snake = {
        Position = {}, -- front - back
        Direction = "left",
        Speed = 5,
        Scale = 1,
        Grow = 0,
        FrameCount = 1,
        Score = 0
    }
    Snake = initPosition(Snake, 5)

    return Snake
end

function DrawSnake(Snake)
    love.graphics.setColor(0, 255, 0, 255)
    for k, v in pairs(Snake.Position) do
        local x = v[1] * Screen.CellSize + (Screen.Mid[1] - Screen.Width / 2)
        local y = v[2] * Screen.CellSize + (Screen.Mid[2] - Screen.Height / 2)
        love.graphics.polygon("fill", {x, y, x + Screen.CellSize, y, x + Screen.CellSize, y + Screen.CellSize, x,
                                       y + Screen.CellSize})
    end
end

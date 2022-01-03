Snake = {
    Position = {}, -- front - back
    Direction = "left",
    Speed = 5,
    Scale = 1,
    Grow = 0
}

FrameCount = 1
function UpdateSnake(dt)
    -- Move Snake
    local newPosition = {}
    if FrameCount % (100 / Snake.Speed) == 0 then
        -- Update tail
        local newTail = nil
        if (Snake.Grow > 0) then
            newTail = Snake.Position[#Snake.Position]
            Snake.Grow = Snake.Grow - 1
        end
        for i = #Snake.Position, 2, -1 do
            newPosition[i] = Snake.Position[i - 1]
        end
        if newTail ~= nil then
            table.insert(newPosition, newTail)
        end
        -- Update head
        newPosition[1] = {(Snake.Position[1][1] + Directions[Snake.Direction][1]) % Game.XCells,
                          (Snake.Position[1][2] + Directions[Snake.Direction][2]) % Game.YCells}

        Snake.Position = newPosition
    end

    FrameCount = FrameCount + 1
end

function GrowSnake()
    Snake.Grow = Snake.Grow + 1
    Game.Score = Game.Score + 1
end

local function initPosition(length, axis)
    local head = {Game.XCells / 2, Game.YCells / 2}
    table.insert(Snake.Position, head)

    for i = 1, length do
        local point = {0, 0}
        if axis % 2 == 0 then
            point[1] = (Snake.Position[#Snake.Position][1] + 1) % Game.XCells
            point[2] = Snake.Position[#Snake.Position][2]

        else
            point[1] = Snake.Position[#Snake.Position][1]
            point[2] = (Snake.Position[#Snake.Position][2] + 1) % Game.YCells
        end
        table.insert(Snake.Position, point)
    end
end

function InitSnake()
    initPosition(5, 0)
end

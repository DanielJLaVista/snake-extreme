require("globals")

Snake = {Position={},
Direction='left',
Speed=5,
Scale=1,
Grow=0,
FrameCount=1,
Score=0}

function Snake:update()
    -- Move Snake
    local newPosition = {}
    if self.FrameCount % (100 / self.Speed) == 0 then
        -- Update tail
        local newTail = nil
        if (self.Grow > 0) then
            newTail = self.Position[#self.Position]
            self.Grow = self.Grow - 1
        end
        for i = #(self.Position), 2, -1 do
            newPosition[i] = self.Position[i - 1]
        end
        if newTail ~= nil then
            table.insert(newPosition, newTail)
        end
        -- Update head
        newPosition[1] = {(self.Position[1][1] + Directions[self.Direction][1]) % Board.XCells,
                          (self.Position[1][2] + Directions[self.Direction][2]) % Board.YCells}

        self.Position = newPosition
    end

    self.FrameCount = self.FrameCount + 1
end

function Snake:growSnake()
    self.Grow = self.Grow + 1
    self.Score = self.Score + 1
end

function Snake:initPosition(length)
    local newPosition = {}
    local head = {Board.XCells / 2, Board.YCells / 2}
    table.insert(newPosition, head)

    for i = 1, length do
        local point = {0, 0}
        point[1] = (newPosition[#newPosition][1] + 1) % Board.XCells
        point[2] = newPosition[#newPosition][2]

        table.insert(newPosition, point)
    end
    self.Position = newPosition
end

function Snake:drawSnake()
    love.graphics.setColor(0, 255, 0, 255)
    for k, v in pairs(self.Position) do
        local x = v[1] * Screen.CellSize + (Screen.Mid[1] - Screen.Width / 2)
        local y = v[2] * Screen.CellSize + (Screen.Mid[2] - Screen.Height / 2)
        love.graphics.polygon("fill", {x, y, x + Screen.CellSize, y, x + Screen.CellSize, y + Screen.CellSize, x,
                                       y + Screen.CellSize})
    end
end

function Snake:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index=self

    self:initPosition(5)
    return o
end
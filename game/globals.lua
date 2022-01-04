-- Up, Left, Down, Right
Directions = {
    up = {0, -1},
    left = {-1, 0},
    down = {0, 1},
    right = {1, 0}
}

Screen = {
    Mid = {love.graphics.getWidth() / 2 - 0.5, love.graphics.getHeight() / 2 - 0.5},
    Width = 768,
    Height = 512,
    CellSize = 8
}

Board = {
    XCells = Screen.Width / Screen.CellSize,
    YCells = Screen.Height / Screen.CellSize,
    Score = 0
}

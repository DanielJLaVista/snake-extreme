require("gamecontroller")

Food = {}

function love.draw()
    DrawGame()
    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2,
                       Screen.Mid[1] + Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)
    love.graphics.line(Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] - Screen.Height / 2,
                       Screen.Mid[1] - Screen.Width / 2, Screen.Mid[2] + Screen.Height / 2)

    love.graphics.print("Score: " .. Game.Snakes[1].Score, 10, 10)
end

function love.update(dt)
    Update()
end

function love.load()
    Reset()
end

function love.quit()
end

function love.keypressed(key)
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

function love.load()
    love.window.setTitle('Random Walker')
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()
    Rows = math.floor(Height/4)
    Cols = math.floor(Width/4)
    X = math.floor(Cols/2)
    Y = math.floor(Rows/2)
    AllOptions = {{ dx= 1, dy= 0 },
                                { dx= -1, dy= 0 },
                                { dx= 0, dy= 1 },
                                { dx= 0, dy= -1 }}
    Walker = {}
    Step = {}
end

function love.update()
    Options = {}
    for _, option in pairs(AllOptions) do
        local newX = X + option.dx
        local newY = Y + option.dy
        if not(newX <= 0 or newX >= Cols or newY <= 0 or newY >= Rows) then
            table.insert(Options,option)
        end
    end
    Step = Options[love.math.random(#Options)]
    X = X + Step.dx
    Y = Y + Step.dy
    table.insert(Walker,{X*math.floor(Width/Cols),Y*math.floor(Height/Rows+1)})
    love.timer.sleep(0.005)
end

function love.draw()
        love.graphics.setPointSize(5)
        love.graphics.setColor(1,1,1,0.15)
        love.graphics.points(Walker)
        love.graphics.setColor(1,0,0)
        love.graphics.points(X*math.floor(Width/Cols),Y*math.floor(Height/Rows+1))
end
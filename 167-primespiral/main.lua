-- #167 Prime Spiral - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Prime Spiral')
    State = 0
    Step, TurnCounter, NumSteps = 1, 1, 1
    StepSize = 4
    local width, height = love.graphics.getPixelDimensions()
    local cols = math.ceil(width / StepSize)
    local rows = math.ceil(height / StepSize)
    TotalSteps = cols * rows
    X = (cols / 2) * StepSize
    Y = ((rows / 2) + 1) * StepSize

    function IsPrime(n)
        if n == 1 then
            return false
        end
        for i = 2, n ^ (1 / 2) do
            if (n % i) == 0 then
                return false
            end
        end
        return true
    end

    Points = {}
    function NewPoint(X, Y, p)
        local point = {}
        point.X = X
        point.Y = Y
        point.p = IsPrime(Step)
        table.insert(Points, point)
    end
end

function love.update()
    NewPoint(X, Y, Step)
    if Step < TotalSteps then
        if State == 0 then
            X = X + StepSize
        elseif State == 1 then
            Y = Y - StepSize
        elseif State == 2 then
            X = X - StepSize
        elseif State == 3 then
            Y = Y + StepSize
        end
        if Step % NumSteps == 0 then
            State = (State + 1) % 4
            TurnCounter = TurnCounter + 1
            if TurnCounter % 2 == 0 then
                NumSteps = NumSteps + 1
            end
        end
        Step = Step + 1
    end
end

function love.draw()
    for ko, point in ipairs(Points) do
        if point.p then
            love.graphics.setColor(1, 1, 1)
            love.graphics.circle('fill', point.X - StepSize / 2, point.Y - StepSize / 2, StepSize / 2)
        end
    end
end

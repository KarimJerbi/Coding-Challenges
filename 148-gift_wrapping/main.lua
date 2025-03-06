-- #148 Gift Wrapping - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Gift Wrapping ')
    Width, Height = love.graphics.getDimensions()
    Points = {}
    Hull = {}
    Buffer = 80
    
    -- Make new Points randomly
    for i = 1, 50 do
        local a = love.math.random(Buffer, Width - Buffer)
        local b = love.math.random(Buffer, Height - Buffer)
        table.insert(Points, {x = a, y = b})
    end
    
    -- Search the the point that is closest to
    -- the left edge of the screen
    -- (replaces the sorting used by Mr.Daniel)
    First = 1
    for i = 2, #Points do
        if Points[i].x < Points[First].x then
            First = i
        end
    end
    
    -- Swap the point #1 with the point that is
    -- the closest to the screen
    Points[1], Points[First] = Points[First], Points[1]
    
    -- workaround to make the shape not collapse on itself
    Points[#Points + 1] = Points[1]
    
    -- Resume the algorithm
    LeftMost = Points[1]
    CurrentVertex = LeftMost
    table.insert(Hull, CurrentVertex.x)
    table.insert(Hull, CurrentVertex.y)
    NextVertex = Points[2]
    Index = 3
    NextIndex = 3
    Count = 2
    Checking = Points[Index]
    Done = false
    Update = true
    
    -- Vector Operations
    function Sub(a, b)
        return {x = a.x - b.x, y = a.y - b.y}
    end
    function Cross(u, v)
        return u.x * v.y - u.y * v.x
    end
end

function love.update()
    if Update then
        local a = Sub(NextVertex, CurrentVertex)
        local b = Sub(Checking, CurrentVertex)
        
        if Cross(a, b) < 0 then
            NextVertex = Checking
            NextIndex = Index
        elseif Index < #Points then
            Index = Index + 1
            Checking = Points[Index]
        else
            Done = true
        end
        
        if Done then
            if NextVertex == Points[1] then
                Update = false
            end
            -- add the found point to the Hull
            table.insert(Hull, NextVertex.x)
            table.insert(Hull, NextVertex.y)
            -- reorder the Points table
            Points[Count], Points[NextIndex] = Points[NextIndex], Points[Count]
            -- Update the indexs
            Index = Count
            NextIndex = Count + 1
            Count = Count + 1
            -- Update the working vertexs
            CurrentVertex = Points[Index]
            NextVertex = Points[NextIndex]
            Checking = Points[Index + 1]
            -- set Done to false
            Done = false
        end
    end
    --love.timer.sleep(0.1)
end

function love.draw()
    love.graphics.setPointSize(10)
    for _, point in pairs(Points) do
        love.graphics.setColor(1, 1, 1)
        love.graphics.points(point.x, point.y)
        love.graphics.setColor(0.78, 0, 1)
        love.graphics.points(CurrentVertex.x, CurrentVertex.y)
        love.graphics.setColor(0, 0.78, 1)
        love.graphics.points(NextVertex.x, NextVertex.y)
        if Update then
            love.graphics.setColor(1, 1, 1)
            love.graphics.line(CurrentVertex.x, CurrentVertex.y, NextVertex.x, NextVertex.y)
            love.graphics.setColor(0.05, 1, 0.05)
            love.graphics.line(CurrentVertex.x, CurrentVertex.y, Checking.x, Checking.y)
        else
            love.graphics.setColor(0.78, 0, 1, 0.005)
            love.graphics.polygon('fill', Hull)
        end
        if #Hull > 2 then
            love.graphics.setColor(0.78, 0, 1)
            love.graphics.line(Hull)
        end
    end
end


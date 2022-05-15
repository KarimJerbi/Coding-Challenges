-- #148 Gift Wrapping - Karim Jerbi(@apolius)

function love.load()
    love.window.setTitle('Gift Wrapping ')
    lg = love.graphics
    lmr = love.math.random
    width, height = lg.getDimensions()
    points = {}
    hull = {}
    buffer = 80
    
    -- Make new points randomly
    for i = 1, 50 do
        local a = lmr(buffer, width - buffer)
        local b = lmr(buffer, height - buffer)
        table.insert(points, {x = a, y = b})
    end
    
    -- Search the the point that is closest to
    -- the left edge of the screen
    -- (replaces the sorting used by Mr.Daniel)
    first = 1
    for i = 2, #points do
        if points[i].x < points[first].x then
            first = i
        end
    end
    
    -- Swap the point #1 with the point that is
    -- the closest to the screen
    points[1], points[first] = points[first], points[1]
    
    -- workaround to make the shape not collapse on itself
    points[#points + 1] = points[1]
    
    -- Resume the algorithm
    leftMost = points[1]
    currentVertex = leftMost
    table.insert(hull, currentVertex.x)
    table.insert(hull, currentVertex.y)
    nextVertex = points[2]
    index = 3
    nextIndex = 3
    count = 2
    checking = points[index]
    done = false
    update = true
    
    -- Vector Operations
    function sub(a, b)
        return {x = a.x - b.x, y = a.y - b.y}
    end
    function cross(u, v)
        return u.x * v.y - u.y * v.x
    end
end

function love.update()
    if update then
        local a = sub(nextVertex, currentVertex)
        local b = sub(checking, currentVertex)
        
        if cross(a, b) < 0 then
            nextVertex = checking
            nextIndex = index
        elseif index < #points then
            index = index + 1
            checking = points[index]
        else
            done = true
        end
        
        if done then
            if nextVertex == points[1] then
                update = false
            end
            -- add the found point to the hull
            table.insert(hull, nextVertex.x)
            table.insert(hull, nextVertex.y)
            -- reorder the points table
            points[count], points[nextIndex] = points[nextIndex], points[count]
            -- update the indexs
            index = count
            nextIndex = count + 1
            count = count + 1
            -- update the working vertexs
            currentVertex = points[index]
            nextVertex = points[nextIndex]
            checking = points[index + 1]
            -- set done to false
            done = false
        end
    end
    --love.timer.sleep(0.1)
end

function love.draw()
    lg.setPointSize(10)
    for _, point in pairs(points) do
        lg.setColor(1, 1, 1)
        lg.points(point.x, point.y)
        lg.setColor(0.78, 0, 1)
        lg.points(currentVertex.x, currentVertex.y)
        lg.setColor(0, 0.78, 1)
        lg.points(nextVertex.x, nextVertex.y)
        if update then
            lg.setColor(1, 1, 1)
            lg.line(currentVertex.x, currentVertex.y, nextVertex.x, nextVertex.y)
            lg.setColor(0.05, 1, 0.05)
            lg.line(currentVertex.x, currentVertex.y, checking.x, checking.y)
        else
            lg.setColor(0.78, 0, 1, 0.005)
            lg.polygon('fill', hull)
        end
        if #hull > 2 then
            lg.setColor(0.78, 0, 1)
            lg.line(hull)
        end
    end
end


-- #180 Falling Sand - Karim Jerbi (@karimjerbi)

function Make2DArray(cols, rows)
    local arr = {}
    for i = 1, cols do
        arr[i] = {}
        for j = 1, rows do
            arr[i][j] = 0
        end
    end
    return arr
end

-- Convert HSV to RGB
function HSVtoRGB(h, s, v)
    local r, g, b
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6
    if i == 0 then
        r, g, b = v, t, p
    elseif i == 1 then
        r, g, b = q, v, p
    elseif i == 2 then
        r, g, b = p, v, t
    elseif i == 3 then
        r, g, b = p, q, v
    elseif i == 4 then
        r, g, b = t, p, v
    elseif i == 5 then
        r, g, b = v, p, q
    end

    return r, g, b
end

local grid
local velocityGrid

local w = 5 --grain size
local cols, rows
local hueValue = 200 / 360 -- Normalize hue to [0, 1] for HSVtoRGB

local gravity = 0.1

-- Check if a column is within the bounds
function WithinCols(i)
    return i >= 1 and i <= cols
end

-- Check if a row is within the bounds
function WithinRows(j)
    return j >= 1 and j <= rows
end

function love.load()
    love.window.setMode(600, 500)
    love.window.setTitle("Falling Sand")
    cols = math.floor(600 / w)
    rows = math.floor(500 / w)
    grid = Make2DArray(cols, rows)
    velocityGrid = Make2DArray(cols, rows)
end

function love.update(dt)
    if love.mouse.isDown(1) then
        local mouseX, mouseY = love.mouse.getPosition()
        local mouseCol = math.floor(mouseX / w) + 1
        local mouseRow = math.floor(mouseY / w) + 1

        -- Randomly add an area of sand particles
        local matrix = 5
        local extent = math.floor(matrix / 2)
        for i = -extent, extent do
            for j = -extent, extent do
                if math.random() < 0.75 then
                    local col = mouseCol + i
                    local row = mouseRow + j
                    if WithinCols(col) and WithinRows(row) then
                        grid[col][row] = hueValue
                        velocityGrid[col][row] = 1
                    end
                end
            end
        end
        -- Change the color of the sand over time
        hueValue = hueValue + 0.5 / 360 -- Normalize increment
        if hueValue > 1 then
            hueValue = 0
        end
    end

    -- Create a 2D array for the next frame of animation
    local nextGrid = Make2DArray(cols, rows)
    local nextVelocityGrid = Make2DArray(cols, rows)

    -- Check every cell
    for i = 1, cols do
        for j = 1, rows do
            -- What is the state?
            local state = grid[i][j]
            local velocity = velocityGrid[i][j]
            local moved = false
            if state > 0 then
                local newPos = math.floor(j + velocity)
                for y = newPos, j + 1, -1 do
                    if y > rows then break end
                    local below = grid[i][y]
                    local dir = 1
                    if math.random() < 0.5 then
                        dir = -1
                    end
                    local belowA = -1
                    local belowB = -1
                    if WithinCols(i + dir) then belowA = grid[i + dir][y] end
                    if WithinCols(i - dir) then belowB = grid[i - dir][y] end

                    if below == 0 then
                        nextGrid[i][y] = state
                        nextVelocityGrid[i][y] = velocity + gravity
                        moved = true
                        break
                    elseif belowA == 0 then
                        nextGrid[i + dir][y] = state
                        nextVelocityGrid[i + dir][y] = velocity + gravity
                        moved = true
                        break
                    elseif belowB == 0 then
                        nextGrid[i - dir][y] = state
                        nextVelocityGrid[i - dir][y] = velocity + gravity
                        moved = true
                        break
                    end
                end
            end

            if state > 0 and not moved then
                nextGrid[i][j] = grid[i][j]
                nextVelocityGrid[i][j] = velocityGrid[i][j] + gravity
            end
        end
    end
    grid = nextGrid
    velocityGrid = nextVelocityGrid
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)

    -- Draw the sand
    for i = 1, cols do
        for j = 1, rows do
            if grid[i][j] > 0 then
                local r, g, b = HSVtoRGB(grid[i][j], 1, 1)
                love.graphics.setColor(r, g, b)
                local x = (i - 1) * w
                local y = (j - 1) * w
                love.graphics.rectangle("fill", x, y, w, w)
            end
        end
    end
end
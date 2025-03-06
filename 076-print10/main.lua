-- #076 Print10 - Karim Jerbi(@karimjerbi)

function HsvToRgb(h, s, v)
    local r, g, b

    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)

    i = i % 6

    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end

    return r, g, b
end

function love.load()
    love.window.setTitle("Print10")
    love.window.setMode(600, 600)
    love.graphics.setBackgroundColor(0, 0, 0)

    X = 0
    Y = 0
    Spacing = 20
    HueValue = 100

    Lines = {}
end

function love.update()
    local X1, Y1, X2, Y2
    if math.random() < 0.1 then
        X1, Y1, X2, Y2 = X, Y, X + Spacing, Y + Spacing
    else
        X1, Y1, X2, Y2 = X, Y + Spacing, X + Spacing, Y
    end

    table.insert(Lines, {X1 = X1, Y1 = Y1, X2 = X2, Y2 = Y2, hue = HueValue})

    X = X + Spacing
    if X > 600 then
        X = 0
        Y = Y + Spacing
    end

    HueValue = HueValue + math.random(-5, 5)
    HueValue = math.max(0, math.min(360, HueValue))
end

function love.draw()
    -- Draw all Lines from the Lines table
    for _, line in ipairs(Lines) do
        local h, s, v = line.hue / 360, 255 / 255, 255 / 255
        local r, g, b = HsvToRgb(h, s, v)
        love.graphics.setColor(r, g, b)
        love.graphics.line(line.X1, line.Y1, line.X2, line.Y2)
    end
end

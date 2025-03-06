-- #013 Reaction Diffusion - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Reaction Diffusion')
    Width, Height = 256, 256
    Pixels = love.image.newImageData(Width, Height)
    Grid = {}
    Nxt = {}
    
    DA = 1
    DB = 0.5
    Feed = 0.055
    K = 0.052
    
    for x = 1, Width - 1 do
        Grid[x] = {}
        Nxt[x] = {}
        for y = 1, Height - 1 do
            Grid[x][y] = {a = 1, b = 0}
            Nxt[x][y] = {a = 1, b = 0}
        end
    end
    
    for i = 96, 160 do
        for j = 96, 160 do
            Grid[i][j].b = 1
        end
    end
    
    function LaplaceA(x, y)
        local sumA = 0
        sumA = Grid[x][y].b * -1
        sumA = sumA + Grid[x - 1][y].a * 0.2
        sumA = sumA + Grid[x + 1][y].a * 0.2
        sumA = sumA + Grid[x][y + 1].a * 0.2
        sumA = sumA + Grid[x][y - 1].a * 0.2
        sumA = sumA + Grid[x - 1][y - 1].a * 0.05
        sumA = sumA + Grid[x + 1][y - 1].a * 0.05
        sumA = sumA + Grid[x + 1][y + 1].a * 0.05
        sumA = sumA + Grid[x - 1][y + 1].a * 0.05
        return sumA
    end
    
    function Clamp(val, min, max)
        return math.max(min, math.min(val, max))
    end
    
    function LaplaceB(x, y)
        local sumB = 0
        sumB = Grid[x][y].b * -1
        sumB = sumB + Grid[x - 1][y].b * 0.2
        sumB = sumB + Grid[x + 1][y].b * 0.2
        sumB = sumB + Grid[x][y + 1].b * 0.2
        sumB = sumB + Grid[x][y - 1].b * 0.2
        sumB = sumB + Grid[x - 1][y - 1].b * 0.05
        sumB = sumB + Grid[x + 1][y - 1].b * 0.05
        sumB = sumB + Grid[x + 1][y + 1].b * 0.05
        sumB = sumB + Grid[x - 1][y + 1].b * 0.05
        return sumB
    end
end

function love.update()
    for x = 2, Width - 2 do
        for y = 2, Height - 2 do
            local a = Grid[x][y].a
            local b = Grid[x][y].b
            Nxt[x][y].a = a + DA * LaplaceA(x, y) - a * b * b + Feed * (1 - a)
            Nxt[x][y].b = b + DB * LaplaceB(x, y) + a * b * b - (K + Feed) * b
            Nxt[x][y].a = Clamp(Nxt[x][y].a, 0, 1)
            Nxt[x][y].b = Clamp(Nxt[x][y].b, 0, 1)
            
        end
    end
    
    for x = 1, Width - 1 do
        for y = 1, Height - 1 do
            local a = Nxt[x][y].a
            local b = Nxt[x][y].b
            local c = a - b
            local c = Clamp(c, 0, 1)
            Pixels:setPixel(x, y, 1, 1, 1, c)
        end
    end
    Out = love.graphics.newImage(Pixels)
    Grid, Nxt = Nxt, Grid
    
end

function love.draw()
    love.graphics.scale(2, 2)
    love.graphics.draw(Out)
end

-- #013 Reaction Diffusion - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Reaction Diffusion')
    lg = love.graphics
    width, height = 256, 256
    pixels = love.image.newImageData(width, height)
    grid = {}
    nxt = {}
    
    dA = 1
    dB = 0.5
    feed = 0.055
    k = 0.052
    
    for x = 1, width - 1 do
        grid[x] = {}
        nxt[x] = {}
        for y = 1, height - 1 do
            grid[x][y] = {a = 1, b = 0}
            nxt[x][y] = {a = 1, b = 0}
        end
    end
    
    for i = 96, 160 do
        for j = 96, 160 do
            grid[i][j].b = 1
        end
    end
    
    function laplaceA(x, y)
        local sumA = 0
        sumA = grid[x][y].b * -1
        sumA = sumA + grid[x - 1][y].a * 0.2
        sumA = sumA + grid[x + 1][y].a * 0.2
        sumA = sumA + grid[x][y + 1].a * 0.2
        sumA = sumA + grid[x][y - 1].a * 0.2
        sumA = sumA + grid[x - 1][y - 1].a * 0.05
        sumA = sumA + grid[x + 1][y - 1].a * 0.05
        sumA = sumA + grid[x + 1][y + 1].a * 0.05
        sumA = sumA + grid[x - 1][y + 1].a * 0.05
        return sumA
    end
    
    function clamp(val, min, max)
        return math.max(min, math.min(val, max))
    end
    
    function laplaceB(x, y)
        local sumB = 0
        sumB = grid[x][y].b * -1
        sumB = sumB + grid[x - 1][y].b * 0.2
        sumB = sumB + grid[x + 1][y].b * 0.2
        sumB = sumB + grid[x][y + 1].b * 0.2
        sumB = sumB + grid[x][y - 1].b * 0.2
        sumB = sumB + grid[x - 1][y - 1].b * 0.05
        sumB = sumB + grid[x + 1][y - 1].b * 0.05
        sumB = sumB + grid[x + 1][y + 1].b * 0.05
        sumB = sumB + grid[x - 1][y + 1].b * 0.05
        return sumB
    end
end

function love.update()
    for x = 2, width - 2 do
        for y = 2, height - 2 do
            local a = grid[x][y].a
            local b = grid[x][y].b
            nxt[x][y].a = a + dA * laplaceA(x, y) - a * b * b + feed * (1 - a)
            nxt[x][y].b = b + dB * laplaceB(x, y) + a * b * b - (k + feed) * b
            nxt[x][y].a = clamp(nxt[x][y].a, 0, 1)
            nxt[x][y].b = clamp(nxt[x][y].b, 0, 1)
            
        end
    end
    
    for x = 1, width - 1 do
        for y = 1, height - 1 do
            local a = nxt[x][y].a
            local b = nxt[x][y].b
            local c = a - b
            local c = clamp(c, 0, 1)
            pixels:setPixel(x, y, 1, 1, 1, c)
        end
    end
    out = love.graphics.newImage(pixels)
    grid, nxt = nxt, grid
    
end

function love.draw()
    lg.scale(2, 2)
    lg.draw(out)
end

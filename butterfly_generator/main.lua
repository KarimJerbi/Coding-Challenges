-- #060 Butterfly Generator - Karim Jerbi(@apolius)

local yoff = 0

function love.load()
    love.window.setTitle("Butterfly Generator")
    love.graphics.setBackgroundColor(51/255, 51/255, 51/255)
end

function love.draw()
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setLineWidth(1)

    local da = math.pi / 200
    local dx = 0.05

    local xoff = 0
    local vertices = {}
    for a = 0, math.pi*2, da do
        local n = love.math.noise(xoff, yoff)
        local r = math.sin(2 * a) * (n * (300 - 50) + 50)
        local x = r * math.cos(a)
        local y = r * math.sin(a)
        if a < math.pi then
            xoff = xoff + dx
        else
            xoff = xoff - dx
        end
        table.insert(vertices, x)
        table.insert(vertices, y)
    end

    love.graphics.polygon("line", unpack(vertices))

    yoff = yoff + 0.01
end
-- #125 Fourier Series - Karim Jerbi(@KarimJerbi)

local time = 0
local wave = {}
local slider_value = 5

function love.load()
    love.window.setMode(600, 400)
    love.window.setTitle('Fourier Series')
end

function love.update(dt)
    time = time + 0.05

    -- Simulate slider functionality with keyboard
    if love.keyboard.isDown('up') and slider_value < 20 then
        slider_value = slider_value + 1
    elseif love.keyboard.isDown('down') and slider_value > 1 then
        slider_value = slider_value - 1
    end

    -- Remove oldest wave point if we have too many
    if #wave > 250 then
        table.remove(wave)
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.translate(150, 200)

    local x = 0
    local y = 0

    for i = 0, slider_value - 1 do
        local prevx = x
        local prevy = y
        local n = i * 2 + 1
        local radius = 75 * (4 / (n * math.pi))
        x = x + radius * math.cos(n * time)
        y = y + radius * math.sin(n * time)

        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.circle("line", prevx, prevy, radius)

        love.graphics.setColor(1, 1, 1)
        love.graphics.line(prevx, prevy, x, y)
    end

    table.insert(wave, 1, y)

    love.graphics.translate(200, 0)
    love.graphics.line(x - 200, y, 0, wave[1])

    love.graphics.push()
    love.graphics.setLineWidth(2)
    for i = 1, #wave do
        love.graphics.line(i - 1, wave[i - 1] or 0, i, wave[i])
    end
    love.graphics.pop()

    -- Display number of terms
    love.graphics.print("Terms: " .. slider_value, -300, -180)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
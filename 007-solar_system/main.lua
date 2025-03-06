-- #007 Solar System 2D - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Solar System')
    Width = love.graphics.getWidth()
    Height = love.graphics.getHeight()

    require('orbs')

    Sun = NewOrb(50,0,1,0)

end

function love.update(dt)
    Orbit(Sun)
    --love.timer.sleep(0.1)
end

function love.draw()
    love.graphics.translate(Width/2, Height/2)
    DrawOrb(Sun)
end

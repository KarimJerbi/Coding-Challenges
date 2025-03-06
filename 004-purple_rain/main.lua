-- #004 Purple Rain - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Purple Rain')
    Window = {}
    Window.width = love.graphics.getWidth()
    Window.height = love.graphics.getHeight()
    Rain = {}
    function Newdrop()
        local drop = {}
        drop.x = love.math.random(Window.width)
        drop.y = love.math.random(-50,0)
        drop.z = love.math.random(1,5)
        drop.h = love.math.random(5,25)
        drop.w = 1.25 * drop.z
        drop.speed = drop.z
        table.insert(Rain,drop)
    end

end

function love.update()
    for i,v in pairs(Rain) do
        v.y = v.y+v.speed
        if v.y >= Window.width then
            table.remove(Rain, i)
        end
    end
    while table.maxn(Rain) < 400 do -- number of stars
        Newdrop()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(230/255, 200/255, 1)
    for _,v in pairs(Rain) do
        love.graphics.setColor(138/255, 43/255, 226/255)
        love.graphics.setLineWidth(v.w)
        love.graphics.line(v.x, v.y, v.x, v.y+v.h)
    end

end

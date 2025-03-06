-- #140 Pi:Leibniz - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('Pi : Leibniz')
    Window = {}
    Window.width = love.graphics.getWidth()
    Window.height = love.graphics.getHeight()

    Pi = 4
    I = 0
    J = -1
    Pies = {0,0}
    X = 0
    function Scale(X)
        Q = math.pi - X	    
        return Q * Window.height
    end

end

function love.update()
    local d = I * 2 + 3
    if (I % 2) == 0 then
        Pi = Pi -(4/d)
    else
        Pi = Pi +(4/d) 
    end

    I = I + 1
    J = J + 2
    table.insert(Pies, J, I*10)
    table.insert(Pies, J+1 , Scale(Pi))

    if love.keyboard.isDown('right') then
        X = X - 10
    elseif love.keyboard.isDown('left') and X ~= 0 then
        X = X+10
    end
end

function love.draw()
    love.graphics.setLineWidth(1.5)
    love.graphics.setLineJoin('bevel')
    love.graphics.translate(0, Window.height/2)
    love.graphics.translate(X,0)
    love.graphics.line(Pies)
    love.graphics.print(Pi, Window.width-125-X, 100)
end

function love.load()
    love.window.setTitle("Binary to Decimal Conversion")
    Width, Height = love.graphics.getDimensions()
    love.graphics.setDefaultFilter('nearest')
    Bits = '11111111'
    R = 255

    function Convert(Bits)
        local r = 0
        for i=1,8 do
            if string.reverse(Bits):sub(i,i) == '1' then
                r = r + 2^(i-1)
            end
        end
        return r
    end

    X,Y = love.mouse.getPosition()

    function Clicked(X,Y,Cx)
        -- check if the mouse has Clicked a bit which x's = cx
        return (X - Cx)^2 + (Y - 100)^2 < 25^2 and love.mouse.isDown(1)
    end

    function Flip(Bits,X)
        local bit = Bits:sub(X,X)
        if bit == '1' then bit = '0' else bit = '1' end
        -- generate a new byte with the new bit
        -- based on the position of the new bit
        -- there are 3 positions: 
        -- start / end \ inside
        if X == 1 then
            return bit .. Bits:sub(2,-1)
        elseif X == Bits:len() then
            return Bits:sub(1,-2)..bit
        else
            return Bits:sub(1,X-1)..bit..Bits:sub(X+1,-1)
        end
    end
end

function love.update(dt)
    X,Y = love.mouse.getPosition()
    for i=1,8 do
        if Clicked(X,Y,20+(i*55))then
            Bits = Flip(Bits,i)
            R = Convert(Bits)
            love.timer.sleep(0.12)
        end
    end
end

function love.draw()
    love.graphics.clear(0.6,0.5,0.75)
    for i=1,8 do
        if Bits:sub(i,i) == '1' then
            love.graphics.setColor(1,1,1)
            love.graphics.ellipse('fill',20+(i*55),100,25,25)
        end
        love.graphics.ellipse('line',20+(i*55),100,25,25)
    end
    love.graphics.print(R,Width/4,Height/4,0,8,8)
end
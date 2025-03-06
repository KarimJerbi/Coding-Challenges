-- #003 The Snake Game - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle('The Snake Game')
    Window = {}
    Window.width = love.graphics.getWidth()
    Window.height = love.graphics.getHeight()
    Window.time = 0
    Gameover = 0
    SCL = 20

    FT = 1
    Score = 0

    Snake = {}
    Snake.x = 0
    Snake.y = 0
    Snake.xspeed = 20
    Snake.yspeed = 0
    Snake.size = 1

    Tail = {}
    function AddtoTail()
        local unit = {}
        unit.x = Snake.x
        unit.y = Snake.y
        unit.xspeed = Snake.xspeed
        unit.yspeed = Snake.yspeed
        table.insert(Tail, Snake.size,unit)
    end
    function UpdateTail() -- Thank you for the help, love2d forums user Xugro ^-^
        if #Tail > 0 then
        for i = 1, #Tail do
                if i == #Tail then
                    Tail[i].x = Snake.x
                    Tail[i].y = Snake.y
                else
                    Tail[i].x = Tail[i+1].x
                    Tail[i].y = Tail[i+1].y

                end
            end
        end
    end

    RGB = {0.1,0.5,0.1}
    function RandomColor()
        local r = love.math.random()
        local g = love.math.random()
        local b = love.math.random()
        return {r,g,b}
    end

    Food = {}
    function NewFood() -- food shouldn't spawn on top of Snake
        RGB = RandomColor()
        local cols = math.floor(Window.width/SCL)
        local rows = math.floor(Window.height/SCL)
        Food.x = love.math.random(cols-1)*SCL
        Food.y = love.math.random(rows-1)*SCL
    end
    NewFood()

    function Eaten(b1,b2)
        local one = not((b1.x+SCL/2 < b2.x) or (b1.x > b2.x+SCL/2))
        local two = not((b1.y+SCL/2 < b2.y) or (b1.y > b2.y+SCL/2))
        return one and two
    end

    function Alive()
        for i, v in ipairs(Tail) do
        if i ~= #Tail then
            if Snake.x == v.x and Snake.y == v.y then
                Gameover = 1
            end
        end
        end
    end

end

function love.update(dt)
    if Gameover == 0 then
        Window.time = Window.time + dt
        -- drive system
        if love.keyboard.isDown('up') and Snake.yspeed~=20 then
            Snake.xspeed = 0
            Snake.yspeed = -20
        elseif love.keyboard.isDown('down') and Snake.yspeed~=-20 then
            Snake.xspeed = 0
            Snake.yspeed = 20
        elseif love.keyboard.isDown('right') and Snake.xspeed~=-20 then
            Snake.xspeed = 20
            Snake.yspeed = 0
        elseif love.keyboard.isDown('left') and Snake.xspeed~=20 then
            Snake.xspeed = -20
            Snake.yspeed = 0
        end
        if Eaten(Snake,Food) then
            Score = Score +1
            if FT == 1 then AddtoTail() FT = FT + 1 end
            Snake.size = Snake.size + 1
            AddtoTail()
            NewFood()
        end
        if Window.time>0.1 then
        -- constrain & move the Snake
            if (Snake.x + SCL < Window.width) and (Snake.xspeed == 20) then
                Snake.x = Snake.x + Snake.xspeed
            end
            if (Snake.x > 0) and (Snake.xspeed == -20) then
                Snake.x = Snake.x + Snake.xspeed
            end
            if (Snake.y + SCL < Window.height) and (Snake.yspeed == 20)then
                Snake.y = Snake.y + Snake.yspeed
            end
            if (Snake.y > 0) and (Snake.yspeed == -20) then
                Snake.y = Snake.y + Snake.yspeed
            end
            Alive()      --check if Snake eat it's tail
            UpdateTail()
            Window.time = 0
        end

    else
        if love.keyboard.isDown('r')then
            Snake.x, Snake.y = 0,0
            Snake.xspeed, Snake.yspeed = 20,0
            local count = #Tail
            for i=0, count do Tail[i]=nil end
            Tail = {}
            Snake.size = 1
            Score = 0
            Gameover = 0
            FT = 1
        end
    end
end

function love.draw()
    love.graphics.setColor(0, 1, 0.2)
    for i,unit in pairs(Tail) do
    love.graphics.rectangle('fill', unit.x, unit.y,SCL,SCL)
    end
    love.graphics.setColor(0, 1, 0.2)
    love.graphics.rectangle('fill', Snake.x, Snake.y, SCL, SCL)
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', Snake.x+15, Snake.y, 5, 5)   -- Make the eyes move according to Snake head movement !
    love.graphics.rectangle('fill', Snake.x+15, Snake.y+15, 5, 5)
    love.graphics.setColor(RGB)
    love.graphics.rectangle('fill', Food.x, Food.y, SCL, SCL)
    love.graphics.setColor(1,1,1)
    love.graphics.print(Score)
    if Gameover == 1 then
        love.graphics.setColor(1,0,0)
        love.graphics.rectangle('line', (Window.width/2)-150, (Window.height/2)-75, 300, 150)
        love.graphics.print('G A M E O V E R',(Window.width/2)-145, (Window.height/2)-75,0,3)
        love.graphics.print('R to restart',(Window.width/2)-60, (Window.height/2)+25,0,2)
    end
end
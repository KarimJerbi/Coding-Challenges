-- #010 Maze Generator - Karim Jerbi(@KarimJerbi)

function love.load()
    love.window.setTitle("Maze Generator")
    love.window.setFullscreen(true)
    Width, Height = love.graphics.getDimensions()
    W = 20
    Cols = math.floor(Width/W)-1
    Rows = math.floor(Height/W)-1

    require "cell"
    Grid = {}
    Stack = {}
    for i = 0, Rows do
        for j = 0, Cols do
            table.insert(Grid,NewCell(j,i))
        end
    end
     Current = Grid[1]
    function RM_Walls(a,b)
        local x = a.i - b.i
        if x == 1 then
            a.walls[4] = false
            b.walls[2] = false
        elseif x == -1 then
            a.walls[2] = false
            b.walls[4] = false
        end
        local y = a.j - b.j
        if y == 1 then
            a.walls[1] = false
            b.walls[3] = false
        elseif y == -1 then
            a.walls[3] = false
            b.walls[1] = false
        end
    end
     --timer = 0 -- timer to slow it down ;)
end

function love.update(dt)
--timer = timer + dt
--if timer > 0.1 then
    Current.visited = true
    Nxt = CheckNeighbors(Current)
    if Nxt ~= nil then
        Nxt.visited = true
        table.insert(Stack,Current)
        RM_Walls(Current,Nxt)
        Current = Nxt
    elseif #Stack > 1 then
        table.remove(Stack,#Stack)
        Current = Stack[#Stack]
    end 
    if love.keyboard.isDown("r") then
        love.event.quit("restart")
    end
    --timer = 0
--end
end

function love.draw()
    for i = 1,#Grid do
        Draw(Grid[i])
    end
    Highlight(Current)
end

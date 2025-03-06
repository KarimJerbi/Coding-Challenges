function love.load()
  love.window.setTitle('Self Avoiding Walk')
  Width = love.graphics.getWidth()
  Height = love.graphics.getHeight()
  Spacing = 50
  Cols = math.floor(Width/Spacing)
  Rows = math.floor(Height/Spacing)
  X = math.floor(Cols/2)
  Y = math.floor(Rows/2)
  Grid = {}
  for i=1, Cols do
    local col = {}
    for j=1,Rows do
      table.insert(col,{})
    end
    table.insert(Grid,col)
  end
  for i=1, Cols do
    for j=1, Rows do
      Grid[i][j] = false
    end
  end
  Grid[X][Y] = true
  AllOptions = {{ dx= 1, dy= 0 },
           { dx= -1, dy= 0 },
           { dx= 0, dy= 1 },
           { dx= 0, dy= -1 }}
  Walker = {}
  WalkerL = {}
  table.insert(Walker,{X*Width/Cols,Y*Height/Rows})
  --  WalkerL is Walker with X,Y not grouped
  --  this is necessary for love.graphics.line 
  table.insert(WalkerL,X*Width/Cols)
  table.insert(WalkerL,Y*Height/Rows)
end

function love.update()
  Options = {}
  for _, option in pairs(AllOptions) do
    local newX = X + option.dx
    local newY = Y + option.dy
    if newX <= 0 or newX >= Cols or newY <= 0 or newY >= Rows then
      Add =  false
    else
      Add = not(Grid[newX][newY])
    end
    if Add then
      table.insert(Options,option)
    end
  end
    if #Options > 0 then
    Step = Options[love.math.random(#Options)]
    X = X + Step.dx
    Y = Y + Step.dy
    Grid[X][Y] = true
    table.insert(Walker,{X*Width/Cols,Y*Height/Rows})
    table.insert(WalkerL,X*Width/Cols)
    table.insert(WalkerL,Y*Height/Rows)
    print('going')
  else
    print('Stuck!')
  end
end

function love.draw()
    love.graphics.setPointSize(10)
    love.graphics.points(Walker)
    love.graphics.line(WalkerL)
end
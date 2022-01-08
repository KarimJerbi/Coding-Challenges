function love.load()
  love.window.setTitle('Self Avoiding Walk')
  lg = love.graphics
  floor = math.floor
  width = lg.getWidth()
  height = lg.getHeight()
  spacing = 50
  cols = floor(width/spacing)
  rows = floor(height/spacing)
  x = floor(cols/2)
  y = floor(rows/2)
  grid = {}
  for i=1, cols do
    local col = {} 
    for j=1,rows do
      table.insert(col,{})
    end
    table.insert(grid,col)
  end
  for i=1, cols do
    for j=1, rows do
      grid[i][j] = false
    end
  end
  grid[x][y] = true
  allOptions = {{ dx= 1, dy= 0 },
           { dx= -1, dy= 0 },
           { dx= 0, dy= 1 },
           { dx= 0, dy= -1 }}
  walker = {}
  walkerL = {}
  table.insert(walker,{x*width/cols,y*height/rows})
  --  walkerL is walker with x,y not grouped
  --  this is necessary for lg.line 
  table.insert(walkerL,x*width/cols)
  table.insert(walkerL,y*height/rows)
end

function love.update()
  options = {}
  for _, option in pairs(allOptions) do
    local newX = x + option.dx
    local newY = y + option.dy
    if newX <= 0 or newX >= cols or newY <= 0 or newY >= rows then
      add =  false
    else
      add = not(grid[newX][newY])
    end
    if add then
      table.insert(options,option)
    end
  end
    if #options > 0 then
    step = options[love.math.random(#options)]
    x = x + step.dx
    y = y + step.dy
    grid[x][y] = true
    table.insert(walker,{x*width/cols,y*height/rows})
    table.insert(walkerL,x*width/cols)
    table.insert(walkerL,y*height/rows)
    print('going')
  else
    print('Stuck!')
  end
end

function love.draw()
    lg.setPointSize(10)
    lg.points(walker)
    lg.line(walkerL) 
end
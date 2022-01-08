function love.load()
  love.window.setTitle('Random Walker')
  lg = love.graphics
  floor = math.floor
  width = lg.getWidth()
  height = lg.getHeight()
  rows = floor(height/4)
  cols = floor(width/4)
  x = floor(cols/2)
  y = floor(rows/2)
  allOptions = {{ dx= 1, dy= 0 },
                { dx= -1, dy= 0 },
                { dx= 0, dy= 1 },
                { dx= 0, dy= -1 }}
  walker = {}
  step = {}
end

function love.update()
  options = {}
  for _, option in pairs(allOptions) do
    local newX = x + option.dx
    local newY = y + option.dy
    if not(newX <= 0 or newX >= cols or newY <= 0 or newY >= rows) then
      table.insert(options,option)
    end
  end
  step = options[love.math.random(#options)]
  x = x + step.dx
  y = y + step.dy
  table.insert(walker,{x*floor(width/cols),y*floor(height/rows+1)})
  love.timer.sleep(0.005)
end

function love.draw()
    lg.setPointSize(5)
    lg.setColor(1,1,1,0.15)
    lg.points(walker)
    lg.setColor(1,0,0)
    lg.points(x*floor(width/cols),y*floor(height/rows+1))
end
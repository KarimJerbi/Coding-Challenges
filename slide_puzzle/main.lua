function love.load()
  image = love.graphics.newImage("img.png")
  love.window.setMode(image:getDimensions())
  love.window.setTitle('Sliding Puzzle')
  require('puzzle')
  puzzle:init(image, 3, 3)
end

function love.update()
  -- Handle mouse clicks
  x,y = love.mouse.getPosition()
  row = math.floor(x / puzzle.tileSize)+1
  col = math.floor(y / puzzle.tileSize)+1
  if love.mouse.isDown(1) and not(isSolved()) then
   puzzle:swapTiles(row, col)
  end
  love.timer.sleep(0.05)
end

function love.draw()
  if puzzle:isSolved() then
    love.graphics.setColor(1,1,1)
    love.graphics.print('SOLVED',0,0,0,3)
    love.graphics.setColor(1,1,1,0.2)
    puzzle:draw()
  else
    love.graphics.setColor(1,1,1)
    puzzle:draw()
  end
end


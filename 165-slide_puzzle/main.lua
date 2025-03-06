-- #165 Sliding Puzzle - Karim Jerbi(@KarimJerbi)
function love.load()
  Image = love.graphics.newImage("img.png")
  love.window.setMode(Image:getDimensions())
  love.window.setTitle('Sliding Puzzle')
  require('Puzzle')
  Puzzle:init(Image, 3, 3)
end

function love.update()
  -- Handle mouse clicks
  X,Y = love.mouse.getPosition()
  local row = math.floor(X / Puzzle.tileSize)+1
  local col = math.floor(Y / Puzzle.tileSize)+1
  if love.mouse.isDown(1) and not(Puzzle:isSolved()) then
   Puzzle:swapTiles(row, col)
  end
  love.timer.sleep(0.05)
end

function love.draw()
  if Puzzle:isSolved() then
    love.graphics.setColor(1,1,1)
    love.graphics.print('SOLVED',0,0,0,3)
    love.graphics.setColor(1,1,1,0.2)
    Puzzle:draw()
  else
    love.graphics.setColor(1,1,1)
    Puzzle:draw()
  end
end


-- #165 Sliding Puzzle - Karim Jerbi(@KarimJerbi)
-- Initialize the Puzzle
Puzzle = {}

function Puzzle:init(image,cols,rows)
  self.image =  image
  self.imageW, self.imageH = self.image:getDimensions()
  self.rows = rows
  self.cols = cols
  self.tileSize = self.imageW / cols
  self.tiles = {}
  self.blankX = cols
  self.blankY = rows
  
  -- Create the tiles
  for y = 1, cols do
    for x = 1, rows do
      local tile = {}
      tile.x = (x - 1) * self.tileSize
      tile.y = (y - 1) * self.tileSize
      tile.num = (y - 1) * cols + x
      tile.img = love.graphics.newQuad(tile.x,
                                       tile.y,
                                       self.tileSize,
                                       self.tileSize,
                                       self.image:getDimensions())
      self.tiles[tile.num]= tile
    end
  end

  -- Check if neighbor
  function IsNeighbor(i, j, x, y)
    if (i ~= x) and (j ~= y) then
      return false
    end
    if (math.abs(i - x) == 1 or math.abs(j - y) == 1) then
      return true
    end
    return false
  end

  -- Swap two tiles
function Puzzle:swapTiles(x, y)
  if x>0 and y>0 and x <= Puzzle.rows and y<= Puzzle.cols and IsNeighbor(self.blankX, self.blankY, x, y) then
    local t1 = (y-1)*self.cols+x
    local t2 = (self.blankY-1)*self.cols+self.blankX
    self.tiles[t1].num, self.tiles[t2].num = self.tiles[t2].num, self.tiles[t1].num
    self.tiles[t1].img, self.tiles[t2].img = self.tiles[t2].img, self.tiles[t1].img
    self.blankX, self.blankY = x, y
  end
end

  -- Shuffle the tiles
  for i = 1, 1000 do
    local dx = love.math.random(-1,1)
    local dy = love.math.random(-1,1)
    if (dx ~= 0 or dy ~= 0) and IsNeighbor(self.blankY + dx, self.blankY + dy, self.blankY, self.blankX) then
     Puzzle:swapTiles(Puzzle.blankX + dx, Puzzle.blankY + dy)
     Puzzle:swapTiles(Puzzle.blankX + dx+1, Puzzle.blankY + dy)
    end
  end
end

-- Draw the Puzzle
function Puzzle:draw()
  for i, tile in ipairs(self.tiles) do
    if i~= (self.blankY-1)*self.cols+self.blankX then
      love.graphics.draw(self.image, tile.img, tile.x, tile.y)
    end
  end
end

function Puzzle:isSolved()
  for i = 1, self.rows do
    for j = 1, self.cols do
     local tile = self.tiles[(j-1)*self.cols+i]
      if tile.num ~= ((j-1)*self.cols+i) then
        return false
      end
    end
  end
  return true
end


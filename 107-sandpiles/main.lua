-- #107 Sand Piles - Karim Jerbi(@KarimJerbi)
-- Define default color
DefaultColor = {255, 0, 0}

-- Define Colors for different sand pile heights
Colors = {
  {255, 255, 0}, -- Yellow
  {0, 185, 63},  -- Green
  {0, 104, 255}, -- Blue
  {122, 0, 229}  -- Purple
}

-- Initialize SandPiles and NextPiles as empty tables
SandPiles = {}
NextPiles = {}

-- love.load is called when the game starts
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest') -- Set filter for graphics
  love.window.setMode(600, 600) -- Set window size
  love.window.setTitle('Sand Piles') -- Set window title

  -- Initialize SandPiles and NextPiles as 2D arrays with width and height equal to the window size
  for i = 1, love.graphics.getWidth() do
    SandPiles[i] = {}
    NextPiles[i] = {}
    for j = 1, love.graphics.getHeight() do
      SandPiles[i][j] = 0
      NextPiles[i][j] = 0
    end
  end

  -- Add a large amount of sand to the center of the screen
  SandPiles[love.graphics.getWidth() / 2][love.graphics.getHeight() / 2] = 1000000000

  love.graphics.setBackgroundColor(unpack(DefaultColor)) -- Set background color
end

-- topple function simulates the sandpile toppling behavior
function Topple()
  -- Copy SandPiles to NextPiles
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      NextPiles[x][y] = SandPiles[x][y]
    end
  end

  -- Simulate toppling
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      local num = SandPiles[x][y]
      if num >= 4 then
        NextPiles[x][y] = NextPiles[x][y] - 4
        if x + 1 <= love.graphics.getWidth() then NextPiles[x + 1][y] = NextPiles[x + 1][y] + 1 end
        if x - 1 >= 1 then NextPiles[x - 1][y] = NextPiles[x - 1][y] + 1 end
        if y + 1 <= love.graphics.getHeight() then NextPiles[x][y + 1] = NextPiles[x][y + 1] + 1 end
        if y - 1 >= 1 then NextPiles[x][y - 1] = NextPiles[x][y - 1] + 1 end
      end
    end
  end

  -- Swap SandPiles and NextPiles
  local tmp = SandPiles
  SandPiles = NextPiles
  NextPiles = tmp
end

-- render function draws the SandPiles to the screen
function Render()
  love.graphics.setColor(unpack(DefaultColor))
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      local num = SandPiles[x][y]
      local col = DefaultColor
      if num == 0 then
        col = Colors[1]
      elseif num == 1 then
        col = Colors[2]
      elseif num == 2 then
        col = Colors[3]
      elseif num == 3 then
        col = Colors[4]
      end

      love.graphics.setColor(unpack(col))
      love.graphics.points({{x, y}})
    end
  end
end

function love.draw()
  Render()

  -- Simulate toppling 50 times per frame
  for i = 1, 50 do
    Topple()
  end
end

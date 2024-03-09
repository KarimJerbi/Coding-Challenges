-- #107 Sand Piles - Karim Jerbi(@KarimJerbi)
-- Define default color
defaultColor = {255, 0, 0}

-- Define colors for different sand pile heights
colors = {
  {255, 255, 0}, -- Yellow
  {0, 185, 63},  -- Green
  {0, 104, 255}, -- Blue
  {122, 0, 229}  -- Purple
}

-- Initialize sandpiles and nextpiles as empty tables
sandpiles = {}
nextpiles = {}

-- love.load is called when the game starts
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest') -- Set filter for graphics
  love.window.setMode(600, 600) -- Set window size
  love.window.setTitle('Sand Piles') -- Set window title

  -- Initialize sandpiles and nextpiles as 2D arrays with width and height equal to the window size
  for i = 1, love.graphics.getWidth() do
    sandpiles[i] = {}
    nextpiles[i] = {}
    for j = 1, love.graphics.getHeight() do
      sandpiles[i][j] = 0
      nextpiles[i][j] = 0
    end
  end

  -- Add a large amount of sand to the center of the screen
  sandpiles[love.graphics.getWidth() / 2][love.graphics.getHeight() / 2] = 1000000000

  love.graphics.setBackgroundColor(unpack(defaultColor)) -- Set background color
end

-- topple function simulates the sandpile toppling behavior
function topple()
  -- Copy sandpiles to nextpiles
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      nextpiles[x][y] = sandpiles[x][y]
    end
  end

  -- Simulate toppling
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      local num = sandpiles[x][y]
      if num >= 4 then
        nextpiles[x][y] = nextpiles[x][y] - 4
        if x + 1 <= love.graphics.getWidth() then nextpiles[x + 1][y] = nextpiles[x + 1][y] + 1 end
        if x - 1 >= 1 then nextpiles[x - 1][y] = nextpiles[x - 1][y] + 1 end
        if y + 1 <= love.graphics.getHeight() then nextpiles[x][y + 1] = nextpiles[x][y + 1] + 1 end
        if y - 1 >= 1 then nextpiles[x][y - 1] = nextpiles[x][y - 1] + 1 end
      end
    end
  end

  -- Swap sandpiles and nextpiles
  local tmp = sandpiles
  sandpiles = nextpiles
  nextpiles = tmp
end

-- render function draws the sandpiles to the screen
function render()
  love.graphics.setColor(unpack(defaultColor))
  for x = 1, love.graphics.getWidth() do
    for y = 1, love.graphics.getHeight() do
      local num = sandpiles[x][y]
      local col = defaultColor
      if num == 0 then
        col = colors[1]
      elseif num == 1 then
        col = colors[2]
      elseif num == 2 then
        col = colors[3]
      elseif num == 3 then
        col = colors[4]
      end

      love.graphics.setColor(unpack(col))
      love.graphics.points({{x, y}})
    end
  end
end

function love.draw()
  render()

  -- Simulate toppling 50 times per frame
  for i = 1, 50 do
    topple()
  end
end

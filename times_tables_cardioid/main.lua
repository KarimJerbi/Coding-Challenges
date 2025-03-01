local factor = 0
local r = 0
local total = 200

function love.load()
  love.window.setMode(800, 600)
  width, height = love.graphics.getDimensions()
  r = height / 2 - 16
end

-- Map index to angle (0,2π)
-- return vector (x,y) on circle
local function getVector(index, total)
  local angle = ((index % total) / total) * (2 * math.pi)
  local x = math.cos(angle + math.pi) * r
  local y = math.sin(angle + math.pi) * r
  return x, y
end

function love.update(dt)
  factor = factor + 0.015
end

function love.draw()
  
  love.graphics.translate(width / 2, height / 2)
  love.graphics.setColor(1, 1, 1, 150/255)
  love.graphics.setLineWidth(2)
  
  love.graphics.circle("line", 0, 0, r)
  
  -- Draw circle lines
  for i = 0, total - 1 do
    local ax, ay = getVector(i, total)
    local bx, by = getVector(i * factor, total)
    love.graphics.line(ax, ay, bx, by)
  end
end
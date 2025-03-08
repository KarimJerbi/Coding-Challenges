-- #055 Mathematical Rose Patterns - Karim Jerbi(@KarimJerbi)

local d = 8
local n = 5

local width = 400
local height = 400

function love.load()
  love.window.setTitle("Mathematical Rose Patterns")
  love.window.setMode(width, height)
end

function love.draw()
  local k = n / d
  love.graphics.clear(51/255, 51/255, 51/255)

  love.graphics.push()
  love.graphics.translate(width / 2, height / 2)

  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(1)
  local vertices = {}

  local step = 0.02
  for a = 0, math.pi * 2 * ReduceDenominator(n, d), step do
    local r = 200 * math.cos(k * a)
    local x = r * math.cos(a)
    local y = r * math.sin(a)
    table.insert(vertices, x)
    table.insert(vertices, y)
  end

  love.graphics.polygon("line", vertices)
  love.graphics.pop()

  -- Display d and n values for clarity (optional)
  love.graphics.setColor(255, 255, 255)
  love.graphics.print("d: " .. d, 10, 10)
  love.graphics.print("n: " .. n, 10, 30)
end

function ReduceDenominator(numerator, denominator)
  local function rec(a, b)
    if b == 0 then
      return a
    else
      return rec(b, a % b)
    end
  end
  return denominator / rec(numerator, denominator)
end

function love.keypressed(key)
  if key == 'up' then
    d = math.min(d + 1, 20)
    print("d increased to " .. d)
  elseif key == 'down' then
    d = math.max(d - 1, 1)
    print("d decreased to " .. d)
  elseif key == 'right' then
    n = math.min(n + 1, 20)
    print("n increased to " .. n)
  elseif key == 'left' then
    n = math.max(n - 1, 1)
    print("n decreased to " .. n)
  elseif key == 'escape' then
    love.event.quit()
  end
end
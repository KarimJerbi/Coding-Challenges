-- #108 The Bransley Fern - Karim Jerbi(@apolius)

function love.load()
  Width = 512
  Height = 512
  love.window.setMode(Width, Height)
  love.window.setTitle("Barnsley Fern")
  X = 0
  Y = 0
end

function love.draw()
  love.graphics.setColor(0, 255, 0)
  love.graphics.rectangle("fill", Width / 2 + X * 50, Height - Y * 50, 1, 1)
  R = math.random()
  local x_new
  local y_new
  if R < 0.01 then
    x_new = 0
    y_new = 0.16 * Y
  elseif R < 0.86 then
    x_new = 0.85 * X + 0.04 * Y
    y_new = -0.04 * X + 0.85 * Y + 1.6
  elseif R < 0.93 then
    x_new = 0.2 * X - 0.26 * Y
    y_new = 0.23 * X + 0.22 * Y + 1.6
  else
    x_new = -0.15 * X + 0.28 * Y
    y_new = 0.26 * X + 0.24 * Y + 0.44
  end
  X = x_new
  Y = y_new
end


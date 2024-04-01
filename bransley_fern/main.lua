-- #108 The Bransley Fern - Karim Jerbi(@apolius)

function love.load()
  width = 512
  height = 512
  love.window.setMode(width, height)
  love.window.setTitle("Barnsley Fern")
  x = 0
  y = 0
end

function love.draw()
  love.graphics.setColor(0, 255, 0)
  love.graphics.rectangle("fill", width / 2 + x * 50, height - y * 50, 1, 1)
  r = math.random()
  if r < 0.01 then
    x_new = 0
    y_new = 0.16 * y
  elseif r < 0.86 then
    x_new = 0.85 * x + 0.04 * y
    y_new = -0.04 * x + 0.85 * y + 1.6
  elseif r < 0.93 then
    x_new = 0.2 * x - 0.26 * y
    y_new = 0.23 * x + 0.22 * y + 1.6
  else
    x_new = -0.15 * x + 0.28 * y
    y_new = 0.26 * x + 0.24 * y + 0.44
  end
  x = x_new
  y = y_new
end


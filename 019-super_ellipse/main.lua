-- #019 Super Ellipse - Karim Jerbi(@KarimJerbi)

local Slider = require("slider")

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

-- superellipse parameters
local a = 100
local b = 100

local mySlider

local function sgn(val)
    if val > 0 then return 1
    elseif val < 0 then return -1
    else return 0
    end
end

function love.load()
    love.window.setTitle('Super Ellipse')
            -- Slider:new(x, y, w, h, minVal, maxVal, initialValue)
    mySlider = Slider:new(50, 30, 300, 10, 0.01, 4, 2)
end

function love.update(dt)
    mySlider:update(dt)
end

function love.mousepressed(x, y, button)
    mySlider:handleMousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
    mySlider:handleMouseReleased(x, y, button)
end

function love.draw()

    mySlider:draw()

    love.graphics.push()
    love.graphics.translate(width / 2, height / 2)

    love.graphics.setColor(1, 1, 1)

    local vertices = {}

    local current_n = math.max(0.001, mySlider.value)
    local na = 2 / current_n

    local angle_increment = 0.1
    local angle = 0
    while angle < (2 * math.pi) do
        local cos_angle = math.cos(angle)
        local sin_angle = math.sin(angle)

        local x = math.pow(math.abs(cos_angle), na) * a * sgn(cos_angle)
        local y = math.pow(math.abs(sin_angle), na) * b * sgn(sin_angle)

        table.insert(vertices, x)
        table.insert(vertices, y)

        angle = angle + angle_increment
    end

    if #vertices >= 4 then
        love.graphics.polygon("line", vertices)
    end

    love.graphics.pop()

end
-- #019 Super Ellipse - Karim Jerbi(@KarimJerbi)

local Slider = require("slider")

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

-- superellipse parameters
local a = 100
local b = 100

local mySlider

local function sgn(val)
  if val > 0 then return 1
  elseif val < 0 then return -1
  else return 0
  end
end

function love.load()
  love.window.setTitle('Super Ellipse')
          -- Slider:new(x, y, w, h, minVal, maxVal, initialValue)
  mySlider = Slider:new(50, 30, 300, 10, 0.01, 4, 2)
end

function love.update(dt)
  mySlider:update(dt)
end

function love.mousepressed(x, y, button)
  mySlider:handleMousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
  mySlider:handleMouseReleased(x, y, button)
end

function love.draw()

  mySlider:draw()

  love.graphics.push()
  love.graphics.translate(width / 2, height / 2)

  love.graphics.setColor(1, 1, 1)

  local vertices = {}

  local current_n = math.max(0.001, mySlider.value)
  local na = 2 / current_n

  local angle_increment = 0.1
  local angle = 0
  while angle < (2 * math.pi) do
      local cos_angle = math.cos(angle)
      local sin_angle = math.sin(angle)

      local x = math.pow(math.abs(cos_angle), na) * a * sgn(cos_angle)
      local y = math.pow(math.abs(sin_angle), na) * b * sgn(sin_angle)

      table.insert(vertices, x)
      table.insert(vertices, y)

      angle = angle + angle_increment
  end

  if #vertices >= 4 then
      love.graphics.polygon("line", vertices)
  end

  love.graphics.pop()

end

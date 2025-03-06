-- #182 Apollonian Gasket - Karim Jerbi(@KarimJerbi)

local Complex = require("complex")

function LerpColor(c1, c2, t)
    local r = c1[1] + (c2[1] - c1[1]) * t
    local g = c1[2] + (c2[2] - c1[2]) * t
    local b = c1[3] + (c2[3] - c1[3]) * t
    local a = c1[4] + (c2[4] - c1[4]) * t

    return {r, g, b, a}
end

local Circle = {}
Circle.__index = Circle

function Circle.new(bend, x, y, index)
  local self = setmetatable({}, Circle)
  self.center = Complex.new(x, y)
  self.bend = bend
  self.radius = math.abs(1 / self.bend)
  self.index = index
  return self
end

local function map(x, in_min, in_max, out_min, out_max)
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

function Circle:show()
  -- Logarithmic mapping for radius
  local t = map( math.log(self.radius), 3.4, math.log(100), 1, 0)
  local col = LerpColor(COLOR1, COLOR2, t)
  love.graphics.setColor(col)
  love.graphics.setLineWidth(0.5)
  love.graphics.circle("fill", self.center.a, self.center.b, self.radius)
  love.graphics.setColor(252/255, 238/255, 33/255)
  love.graphics.circle("line", self.center.a, self.center.b, self.radius)
end

function Circle:dist(other)
  return math.sqrt((self.center.a - other.center.a)^2 + (self.center.b - other.center.b)^2)
end

return Circle
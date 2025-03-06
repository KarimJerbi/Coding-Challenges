-- #182 Apollonian Gasket - Karim Jerbi(@KarimJerbi)

local Complex = {}
Complex.__index = Complex

function Complex.new(a, b)
  local self = setmetatable({}, Complex)
  self.a = a or 0
  self.b = b or 0
  return self
end

function Complex:add(other)
  return Complex.new(self.a + other.a, self.b + other.b)
end

function Complex:sub(other)
  return Complex.new(self.a - other.a, self.b - other.b)
end

function Complex:scale(value)
  return Complex.new(self.a * value, self.b * value)
end

function Complex:mult(other)
  return Complex.new(
    self.a * other.a - self.b * other.b,
    self.a * other.b + other.a * self.b
  )
end
local function getAngle(x, y)
  local angle = math.atan(y / x)

  -- Handle quadrants:
  if x < 0 and y >= 0 then
    angle = angle + math.pi
  elseif x < 0 and y < 0 then
    angle = angle - math.pi
  elseif x == 0 and y > 0 then
    angle = math.pi / 2
  elseif x == 0 and y < 0 then
    angle = -math.pi / 2
  elseif x == 0 and y == 0 then
    angle = 0
  end

  return angle
end

function Complex:sqrt()
  local m = math.sqrt(self.a * self.a + self.b * self.b)
  local angle = getAngle(self.a, self.b)
  m = math.sqrt(m)
  angle = angle / 2
  return Complex.new(m * math.cos(angle), m * math.sin(angle))
end

return Complex
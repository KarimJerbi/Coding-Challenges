-- #182 Apollonian Gasket - Karim Jerbi(@KarimJerbi)

local Circle = require("circle")
local Complex = require("complex")

-- Constants
local epsilon = 0.01
local index = 0

-- Utility functions
local function isTangent(c1, c2)
  local d = c1:dist(c2)
  local r1 = c1.radius
  local r2 = c2.radius
  return math.abs(d - (r1 + r2)) < epsilon or math.abs(d - math.abs(r2 - r1)) < epsilon
end

local function validate(c4, c1, c2, c3, allCircles)
  if c4.radius < 5 then return false end

  for _, other in ipairs(allCircles) do
    local d = c4:dist(other)
    local radiusDiff = math.abs(c4.radius - other.radius)
    if d < epsilon and radiusDiff < epsilon then
      return false
    end
  end

  -- Check if all 4 circles are mutually tangential
  if not isTangent(c4, c1) then return false end
  if not isTangent(c4, c2) then return false end
  if not isTangent(c4, c3) then return false end

  return true
end

-- vector math
local vector = {}
vector.__index = vector
local function newV(x,y)
    return setmetatable({x=x or 0, y=y or 0}, vector)
end

function vector:scale(s)
    self.x = self.x * s
    self.y = self.y * s
end

function vector:rotate(angle)
    local s = math.sin(angle)
    local c = math.cos(angle)
    local v = newV((c * self.x) + (s * self.y),-(s * self.x) + (c * self.y))
    self.x, self.y = v.x, v.y
    return self
end

function vector:len()
    return math.sqrt(self.x * self.x + self.y * self.y)
end

function vector:setMag(x)
  local currentMag = self:len()
  if currentMag == 0 then return end -- Avoid division by zero (vector is nil)
  self:scale(x / currentMag)
  return self
end


-- Gasket class
local Gasket = {}
Gasket.__index = Gasket

function Gasket:nextGeneration()
    local nextQueue = {}
    for _, triplet in ipairs(self.queue) do
      local c1, c2, c3 = unpack(triplet)
      local k4 = descartes(c1, c2, c3)
      local newCircles = complexDescartes(c1, c2, c3, k4)
      for _, newCircle in ipairs(newCircles) do
        if validate(newCircle, c1, c2, c3, self.allCircles) then
          table.insert(self.allCircles, newCircle)
          table.insert(nextQueue, {c1, c2, newCircle})
          table.insert(nextQueue, {c1, c3, newCircle})
          table.insert(nextQueue, {c2, c3, newCircle})
        end
      end
    end
    self.queue = nextQueue
end

function Gasket.new(x, y, r, color, seed)
  local self = setmetatable({}, Gasket)
  math.randomseed(seed)

  self.allCircles = {}
  self.queue = {}

  local c1 = Circle.new(-1 / r, x, y, index)

  -- Calculate the positions of c2 and c3 using vectors
  local r2 = math.random(20, c1.radius / 2)
  local v = newV(math.random(-1, 1), math.random(-1, 1))
  v:setMag(c1.radius - r2)
  local c2 = Circle.new(1 / r2, x + v.x, y + v.y, index)
  local r3 = v:len()
  v:rotate(math.pi)
  v:setMag(c1.radius - r3)
  local c3 = Circle.new(1 / r3, x + v.x, y + v.y, index)

  self.allCircles = {c1, c2, c3}
  self.queue = {{c1, c2, c3}}
  self.color = color
  self.recursed = true
  self.startC = {c1, c2, c3}

  local len = -1
  while #self.allCircles ~= len do
    len = #self.allCircles
    self:nextGeneration()
  end

  return self
end

function Gasket:recurse()
  if self.recursed then return end
  self.recursed = true
  local newGaskets = {}
  for i = 2, #self.allCircles do
    local c = self.allCircles[i]
    if c.radius < 0.1 then break end
    table.insert(newGaskets, Gasket.new(c.center.a, c.center.b, c.radius, self.color, math.random(100000)))
  end
  return newGaskets
end

function Gasket:show()
  for _, c in ipairs(self.allCircles) do
    c:show(self.color)
  end
end

function complexDescartes(c1, c2, c3, k4)
  local k1 = c1.bend
  local k2 = c2.bend
  local k3 = c3.bend
  local z1 = c1.center
  local z2 = c2.center
  local z3 = c3.center

  local zk1 = z1:scale(k1)
  local zk2 = z2:scale(k2)
  local zk3 = z3:scale(k3)
  local sum = zk1:add(zk2):add(zk3)

  local root = zk1:mult(zk2):add(zk2:mult(zk3)):add(zk1:mult(zk3))
  root = root:sqrt():scale(2)
  local center1 = sum:add(root):scale(1 / k4[1])
  local center2 = sum:sub(root):scale(1 / k4[1])
  local center3 = sum:add(root):scale(1 / k4[2])
  local center4 = sum:sub(root):scale(1 / k4[2])

  index = index + 1

  return {
    Circle.new(k4[1], center1.a, center1.b, index),
    Circle.new(k4[1], center2.a, center2.b, index),
    Circle.new(k4[2], center3.a, center3.b, index),
    Circle.new(k4[2], center4.a, center4.b, index)
  }
end

function descartes(c1, c2, c3)
  local k1 = c1.bend
  local k2 = c2.bend
  local k3 = c3.bend

  local sum = k1 + k2 + k3
  local product = math.abs(k1 * k2 + k2 * k3 + k1 * k3)
  local root = 2 * math.sqrt(product)
  return {sum + root, sum - root}
end

return Gasket
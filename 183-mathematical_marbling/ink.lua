-- #183 Mathematical Marbling - Karim Jerbi(@KarimJerbi)
-- Ink drop class
Drop = {}
Drop.__index = Drop
local CircleDetail = 50

local function map(x, in_min, in_max, out_min, out_max)
    return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
end

-- Create a new drop
function Drop:new(x, y, r)
	self = setmetatable({}, Drop)
    self.color = {love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255)}
    self.center = {x = x, y = y}
    self.r = r
    self.vertices = {}
    for i = 0, CircleDetail do
        local angle = map(i, 0, CircleDetail, 0, (math.pi*2))
        local v ={x = math.cos(angle), y = math.sin(angle)}
        v.x, v.y = v.x * self.r, v.y * self.r
        v.x, v.y = v.x + self.center.x, v.y + self.center.y
        self.vertices[i] = v
    end
	return self
end

-- Rotate a vector
function Rotate(v, theta)
    local s = math.sin(theta)
    local c = math.cos(theta)
    local Nv = {x = (c * v.x) + (s * v.y),
               y = -(s * v.x) + (c * v.y)}
    return Nv
  end

-- Apply tine effect to a drop
function Drop:tine(m, x, y, z, c)
    local u = 1 / 2^(1 / c)
    local b = {x = x, y = y}
	for i,v in ipairs(self.vertices) do
        local pb = {x = v.x - b.x, y = v.y - b.y}
        local n = Rotate(m, math.pi/2)
        local d = math.abs(pb.x * n.x + pb.y * n.y)
        local mag = z * (u ^ d)*10
        self.vertices[i].x = v.x + m.x * mag
        self.vertices[i].y = v.y + m.y * mag
    end
end

-- Function to simulate the interaction of two drops
function Drop:marble(other)
    for _,v in ipairs(self.vertices) do
        local c = other.center
        local r = other.r
        local p = {x = v.x - c.x, y = v.y - c.y}
        local m = math.sqrt(p.x^2 + p.y^2)
        local root = math.sqrt(1+ (r * r) / (m * m))
        p = {x = p.x * root, y = p.y * root}
        p = {x = p.x + c.x, y = p.y + c.y}
        v.x = p.x
        v.y = p.y
    end
end

-- Draw the drop
function Drop:draw()
    local sorted = {}
	for i = 1, #self.vertices - 1 do
		table.insert(sorted, self.vertices[i].x)
		table.insert(sorted, self.vertices[i].y)
	end
	table.insert(sorted, self.vertices[#self.vertices].x)
	table.insert(sorted, self.vertices[#self.vertices].y)
	love.graphics.setColor(self.color[1] / 255, self.color[2] / 255, self.color[3] / 255)
	love.graphics.polygon("fill", sorted)
end

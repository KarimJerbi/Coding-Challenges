-- #145 2D Ray Casting - Karim Jerbi (@KarimJerbi) 01-2025

Particle = {}
Particle.__index = Particle

function Particle.new()
    local self = setmetatable({}, Particle)
    self.pos = {x = 200, y = 200}
    self.rays = {}
    for a = 0, 360, 1 do
        table.insert(self.rays, Ray.new(self.pos, math.rad(a)))
    end
    return self
end

function Particle:update(x, y)
    self.pos.x = x
    self.pos.y = y
end

function Particle:look(Walls)
    for i, ray in ipairs(self.rays) do
        local closest = nil
        local record = math.huge
        for _, wall in ipairs(Walls) do
            local pt = ray:cast(wall)
            if pt then
                local d = self:distance(self.pos, pt)
                if d < record then
                    record = d
                    closest = pt
                end
            end
        end
        if closest then
            love.graphics.setColor(255, 255, 255, 100)
            love.graphics.line(self.pos.x, self.pos.y, closest.x, closest.y)
        end
    end
end

function Particle:show()
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, 2)
    for _, ray in ipairs(self.rays) do
        ray:show()
    end
end

function Particle:distance(a, b)
    return math.sqrt((a.x - b.x)^2 + (a.y - b.y)^2)
end
-- #145 2D Ray Casting - Karim Jerbi (@KarimJerbi) 01-2025

Ray = {}
Ray.__index = Ray

function Ray.new(pos, angle)
    local self = setmetatable({}, Ray)
    self.pos = pos
    self.dir = {x = math.cos(angle), y = math.sin(angle)}
    return self
end

function Ray:lookAt(x, y)
    self.dir.x = x - self.pos.x
    self.dir.y = y - self.pos.y
    local len = math.sqrt(self.dir.x^2 + self.dir.y^2)
    self.dir.x = self.dir.x / len
    self.dir.y = self.dir.y / len
end

function Ray:show()
    love.graphics.setColor(255, 255, 255)
    love.graphics.line(self.pos.x, self.pos.y, self.pos.x + self.dir.x * 10, self.pos.y + self.dir.y * 10)
end

function Ray:cast(wall)
    local x1 = wall.a.x
    local y1 = wall.a.y
    local x2 = wall.b.x
    local y2 = wall.b.y

    local x3 = self.pos.x
    local y3 = self.pos.y
    local x4 = self.pos.x + self.dir.x
    local y4 = self.pos.y + self.dir.y

    local den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4)
    if den == 0 then
        return nil
    end

    local t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den
    local u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den
    if t > 0 and t < 1 and u > 0 then
        local pt = {x = x1 + t * (x2 - x1), y = y1 + t * (y2 - y1)}
        return pt
    else
        return nil
    end
end

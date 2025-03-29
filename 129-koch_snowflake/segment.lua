-- #129 Koch Snowflake - Karim Jerbi (@KarimJerbi)

Vec = require('vector')

local Segment = {}
Segment.__index = Segment

function Segment:new(a, b)
    local instance = setmetatable({}, Segment)
    instance.a = Vec.copy(a) --save a copy
    instance.b = Vec.copy(b)
    return instance
end

function Segment:generate()
    local children = {}

    local v = Vec.sub(self.b, self.a)
    v = Vec.div(v, 3)

    local b1 = Vec.add(self.a, v)
    local a1 = Vec.sub(self.b, v)

    children[1] = Segment:new(self.a, b1)

    children[4] = Segment:new(a1, self.b)

    local rotated_v = Vec.rotate(v, -math.pi / 3)

    local c = Vec.add(b1, rotated_v)

    children[2] = Segment:new(b1, c)

    children[3] = Segment:new(c, a1)

    return children
end

function Segment:show()
    love.graphics.line(self.a.x, self.a.y, self.b.x, self.b.y)
end

return Segment

-- #015 Fractal Tree Array - Karim Jerbi(@KarimJerbi)

local vector = require("vector")

local Branch = {}
Branch.__index = Branch

function Branch.new(origin_point_ref, ending_vec)
    local self = setmetatable({}, Branch)
    -- reference to the vector table this branch starts from (parent's ending point)
    self.origin_ref = origin_point_ref

    self.begin = vector.copy(origin_point_ref)
    self.ending = ending_vec
    self.finished = false
    return self
end

function Branch:show()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.line(self.begin.x, self.begin.y, self.ending.x, self.ending.y)
end

function Branch:branchA()
    local dir = vector.sub(self.ending, self.begin)
    dir = vector.rotate(dir, math.pi / 6)
    dir = vector.mult(dir, 0.67)
    local newEnding = vector.add(self.ending, dir)
    -- parent branch's 'ending' as the origin for the child branch
    local b = Branch.new(self.ending, newEnding)
    return b
end

function Branch:branchB()
    local dir = vector.sub(self.ending, self.begin)
    dir = vector.rotate(dir, -math.pi / 4)
    dir = vector.mult(dir, 0.67)
    local newEnding = vector.add(self.ending, dir)
    -- parent branch's 'ending' as the origin for the child branch
    local b = Branch.new(self.ending, newEnding)
    return b
end

return Branch

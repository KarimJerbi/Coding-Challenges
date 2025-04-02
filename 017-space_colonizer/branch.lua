-- #017 Space Colonizer - Karim Jerbi(@KarimJerbi)
local Branch = {}
Branch.__index = Branch

function Branch:new(parent, pos, dir)
    local instance = setmetatable({}, Branch)
    instance.pos = pos
    instance.parent = parent
    instance.dir = dir
    instance.origDir = {x = dir.x, y = dir.y}
    instance.count = 0
    instance.len = 5
    return instance
end

function Branch:reset()
    local currentDir = {x = self.dir.x, y = self.dir.y}
    self.origDir = currentDir
    self.dir = {x = self.origDir.x, y = self.origDir.y}
    self.count = 0
end

function Branch:next()
    local nextDir = {
        x = self.dir.x * self.len,
        y = self.dir.y * self.len
    }

    local nextPos = {
        x = self.pos.x + nextDir.x,
        y = self.pos.y + nextDir.y
    }


    local nextBranch = Branch:new(self, nextPos, {x = self.dir.x, y = self.dir.y})
    return nextBranch
end

function Branch:show()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(2)
    if self.parent then
        love.graphics.line(self.pos.x, self.pos.y, self.parent.pos.x, self.parent.pos.y)
    else
        love.graphics.circle("fill", self.pos.x, self.pos.y, 2)
    end
end

return Branch

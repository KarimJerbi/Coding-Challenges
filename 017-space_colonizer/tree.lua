-- #017 Space Colonizer - Karim Jerbi(@KarimJerbi)
local Leaf = require("leaf")
local Branch = require("branch")

local max_dist = 200
local min_dist = 5

local Tree = {}
Tree.__index = Tree

function Tree:new()
    local instance = setmetatable({}, Tree)
    instance.leaves = {}
    instance.branches = {}

    for i = 1, 500 do
        table.insert(instance.leaves, Leaf:new())
    end

    local pos = {x = love.graphics.getWidth() / 2, y = love.graphics.getHeight()}
    local dir = {x = 0, y = -1}
    local root = Branch:new(nil, pos, dir)
    table.insert(instance.branches, root)

    instance.current = root
    instance.found = false

    return instance
end

function Tree:grow()
    for i = #self.leaves, 1, -1 do
        local leaf = self.leaves[i]
        local closestBranch = nil
        local record = max_dist

        for j = 1, #self.branches do
            local branch = self.branches[j]
            local d = self:distance(leaf.pos, branch.pos)

            if d < min_dist then
                leaf.reached = true
                closestBranch = nil
                break
            elseif d < record and not leaf.reached then
                closestBranch = branch
                record = d
            end
        end

        if closestBranch then
            local newDir = {
                x = leaf.pos.x - closestBranch.pos.x,
                y = leaf.pos.y - closestBranch.pos.y
            }

            local len = math.sqrt(newDir.x * newDir.x + newDir.y * newDir.y)
            newDir.x = newDir.x / len
            newDir.y = newDir.y / len

            closestBranch.dir.x = closestBranch.dir.x + newDir.x + 0.1
            closestBranch.dir.y = closestBranch.dir.y + newDir.y + 0.1

            -- how many leaves are affecting this branch
            closestBranch.count = closestBranch.count + 1
        end
    end

    for i = #self.leaves, 1, -1 do
        if self.leaves[i].reached then
            table.remove(self.leaves, i)
        end
    end

    for i = #self.branches, 1, -1 do
        local branch = self.branches[i]
        if branch.count > 0 then
            -- Normalize the direction based on the count
            branch.dir.x = branch.dir.x / branch.count
            branch.dir.y = branch.dir.y / branch.count

            -- Normalize to length 1
            local len = math.sqrt(branch.dir.x * branch.dir.x + branch.dir.y * branch.dir.y)
            branch.dir.x = branch.dir.x / len
            branch.dir.y = branch.dir.y / len

            local newBranch = branch:next()
            table.insert(self.branches, newBranch)

            branch:reset()
        end
    end

    if #self.leaves == 0 then
        self.found = true
    end
end

function Tree:show()
    for i = 1, #self.branches do
        self.branches[i]:show()
    end

    for i = 1, #self.leaves do
        self.leaves[i]:show()
    end
end

function Tree:distance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    return math.sqrt(dx * dx + dy * dy)
end

return Tree

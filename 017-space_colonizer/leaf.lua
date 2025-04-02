-- #017 Space Colonizer - Karim Jerbi(@KarimJerbi)
local Leaf = {}
Leaf.__index = Leaf

function Leaf:new(x, y)
    local instance = setmetatable({}, Leaf)
    instance.pos = {x = x or love.math.random(love.graphics.getWidth()), y = y or love.math.random(love.graphics.getHeight() - 100)}
    instance.reached = false
    return instance
end

function Leaf:show()
    love.graphics.setColor(1, 1, 1)
    love.graphics.ellipse("fill", self.pos.x, self.pos.y, 4, 4)
end

return Leaf

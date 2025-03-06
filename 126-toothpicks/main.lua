-- #126 Toothpicks - Karim Jerbi(@KarimJerbi)

local picks = {}
local len = 63
local minx, maxx
local frameCount = 0
local maxFrames = 200

local Toothpick = {}
Toothpick.__index = Toothpick

function Toothpick:new(x, y, d)
    local self = setmetatable({}, Toothpick)
    self.newPick = true
    self.dir = d
    if self.dir == 1 then
        self.ax = x - len/2
        self.bx = x + len/2
        self.ay = y
        self.by = y
    else
        self.ax = x
        self.bx = x
        self.ay = y - len/2
        self.by = y + len/2
    end
    return self
end

-- Check for intersection
function Toothpick:intersects(x, y)
    if self.ax == x and self.ay == y then
        return true
    elseif self.bx == x and self.by == y then
        return true
    else
        return false
    end
end

-- Create a new toothpick from endpoint A if that point is not already used.
function Toothpick:createA(others)
    local available = true
    for _, other in ipairs(others) do
        if other ~= self and other:intersects(self.ax, self.ay) then
            available = false
            break
        end
    end
    if available then
        return Toothpick:new(self.ax, self.ay, self.dir * -1)
    else
        return nil
    end
end

-- Create a new toothpick from endpoint B if that point is not already used.
function Toothpick:createB(others)
    local available = true
    for _, other in ipairs(others) do
        if other ~= self and other:intersects(self.bx, self.by) then
            available = false
            break
        end
    end
    if available then
        return Toothpick:new(self.bx, self.by, self.dir * -1)
    else
        return nil
    end
end

function Toothpick:show(factor)
    if self.newPick then
        love.graphics.setColor(0, 0, 1)
    else
        love.graphics.setColor(0, 0, 0)
    end
    love.graphics.setLineWidth(1 / factor)
    love.graphics.line(self.ax, self.ay, self.bx, self.by)
end

function love.load()
    love.window.setMode(600, 600)
    love.graphics.setBackgroundColor(1, 1, 1)
    love.window.setTitle("Toothpicks")

    -- initialize minx and maxx for scaling
    local w = love.graphics.getWidth()
    minx = -w/2
    maxx = w/2

    -- starter toothpick
    table.insert(picks, Toothpick:new(0, 0, 1))
end

function love.update(dt)
    if frameCount >= maxFrames then
        return
    end

    frameCount = frameCount + 1
    local nextPicks = {}

    -- For each existing toothpick, if it is new, try to create child picks.
    for _, t in ipairs(picks) do
        if t.newPick then
            local nextA = t:createA(picks)
            local nextB = t:createB(picks)
            if nextA then
                table.insert(nextPicks, nextA)
            end
            if nextB then
                table.insert(nextPicks, nextB)
            end
            t.newPick = false
        end
    end

    -- Add the new toothpicks
    for _, np in ipairs(nextPicks) do
        table.insert(picks, np)
    end

    -- Update the minx and max values for scaling.
    for _, t in ipairs(picks) do
        if t.ax < minx then minx = t.ax end
        if t.ax > maxx then maxx = t.ax end
        if t.bx < minx then minx = t.bx end
        if t.bx > maxx then maxx = t.bx end
    end
end

function love.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.translate(w/2, h/2)

    -- compute scaling factor so that the structure fits within the window.
    local factor = w / (maxx - minx)
    love.graphics.scale(factor, factor)

    for _, t in ipairs(picks) do
      t:show(factor)
  end
end
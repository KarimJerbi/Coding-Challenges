-- #145 2D Ray Casting - Karim Jerbi (@KarimJerbi) 01-2025

require 'ray'
require "particle"

Boundary = {}
Boundary.__index = Boundary

function Boundary.new(x1, y1, x2, y2)
    local self = setmetatable({}, Boundary)
    self.a = {x = x1, y = y1}
    self.b = {x = x2, y = y2}
    return self
end

function Boundary:show()
    love.graphics.setColor(255, 255, 255)
    love.graphics.line(self.a.x, self.a.y, self.b.x, self.b.y)
end

function love.load()
    love.window.setTitle("2D Ray Casting")
    Size = 400
    love.window.setMode(Size, Size, {resizable = false})
    math.randomseed(os.time())

    Walls = {}
    -- Generate random walls
    for i = 1, 5 do
        local x1 = math.random(0, 400)
        local x2 = math.random(0, 400)
        local y1 = math.random(0, 400)
        local y2 = math.random(0, 400)
        table.insert(Walls, Boundary.new(x1, y1, x2, y2))
    end

    -- Add borders to Walls
    table.insert(Walls, Boundary.new(-1, -1, 401, -1))
    table.insert(Walls, Boundary.new(Size + 1, -1, Size + 1, Size + 1))
    table.insert(Walls, Boundary.new(Size + 1, Size + 1, -1, Size + 1))
    table.insert(Walls, Boundary.new(-1, Size + 1, -1, -1))

    Particle = Particle.new()
end

function love.update(dt)
    local mouseX, mouseY = love.mouse.getPosition()
    Particle:update(mouseX, mouseY)
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)

    for _, wall in ipairs(Walls) do
        wall:show()
    end

    Particle:show()
    Particle:look(Walls)
end
-- #132 Fluid Simulation - Karim Jerbi (@KarimJerbi) 01-2025

local fluid = require("fluid")

local SCALE = 4
local t = 0
local width = 512
local height = 512

local fluidInstance

function love.load()
    love.window.setTitle('Fluid Simulation')
    love.window.setMode(width, height)    
    fluidInstance = fluid.new(0.2, 0, 0.0000001)
end

function love.update(dt)
    local cx = math.floor((0.5 * width) / SCALE)
    local cy = math.floor((0.5 * height) / SCALE)

    for i = -1, 1 do
        for j = -1, 1 do
            fluid.addDensity(fluidInstance, cx + i, cy + j, math.random(50, 150))
        end
    end

    for i = 1, 2 do
        local angle = love.math.noise(t) * math.pi * 2 * 2
        local vx = math.cos(angle) * 0.2
        local vy = math.sin(angle) * 0.2
        t = t + 0.01
        fluid.addVelocity(fluidInstance, cx, cy, vx, vy)
    end

    fluid.step(fluidInstance)

end

function love.draw()
  love.graphics.setColor(51/255, 51/255, 51/255) -- Set stroke color
  love.graphics.setLineWidth(2)
  fluid.renderD(fluidInstance)

end

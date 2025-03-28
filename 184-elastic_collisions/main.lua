-- #185 Elastic Collisions - Karim Jerbi(@KarimJerbi)

local Particle = require('particle')

local particleA
local particleB
local width, height

function love.load()
    width, height = love.graphics.getDimensions()
    love.window.setTitle("Elastic Collisions")

    particleA = Particle:new(width / 2, 60)
    particleB = Particle:new(width / 2, height - 60)
end

function love.update()

    particleA:collide(particleB)

    particleA:update()
    particleB:update()

    particleA:edges()
    particleB:edges()
end

function love.draw()
    particleA:show()
    particleB:show()
end

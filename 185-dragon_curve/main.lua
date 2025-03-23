-- #185 Tic Tac Toe - Karim Jerbi(@KarimJerbi)

local LSystem = require "lsystem"
local Turtle = require "turtle"

local lsystem
local turtle

function love.load()
    love.window.setTitle("Dragon Curve")
    Width = 640
    Height = 360

    local rules = {
        X = "X+YF+",
        Y = "-FX-Y",
    }
    lsystem = LSystem:new("FX", rules)
    turtle = Turtle:new(2, math.rad(90))

    for i = 1, 14 do
        lsystem:generate()
    end
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.translate(Width / 1.5, Height / 2.5)
    love.graphics.scale(1 + love.timer.getTime() * 0.1)
    turtle:renderStep(lsystem.sentence)
end

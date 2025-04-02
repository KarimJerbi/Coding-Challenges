-- #017 Space Colonizer - Karim Jerbi(@KarimJerbi)
local Tree = require("tree")

local tree1

function love.load()
    love.window.setTitle("Space Colonizer")
    love.window.setMode(640, 360)
    tree1 = Tree:new()
end

function love.update(dt)
    tree1:grow()
end

function love.draw()
    love.graphics.clear(0, 0, 0)
    tree1:show()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "r" then
        tree1 = Tree:new()
    end
end

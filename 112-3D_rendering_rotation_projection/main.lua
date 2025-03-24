local matrix = require("matrix")

local angle = 0
local points = {}

local function connect(i, j, Ps)
    local a = Ps[i]
    local b = Ps[j]
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(1)
    love.graphics.line(a.x, a.y, b.x, b.y)
end

function love.load()
    love.window.setTitle('3D rotation projection')
    love.window.setMode(400, 400)
    points[1] = { x = -0.5, y = -0.5, z = -0.5 }
    points[2] = { x = 0.5, y = -0.5, z = -0.5 }
    points[3] = { x = 0.5, y = 0.5, z = -0.5 }
    points[4] = { x = -0.5, y = 0.5, z = -0.5 }
    points[5] = { x = -0.5, y = -0.5, z = 0.5 }
    points[6] = { x = 0.5, y = -0.5, z = 0.5 }
    points[7] = { x = 0.5, y = 0.5, z = 0.5 }
    points[8] = { x = -0.5, y = 0.5, z = 0.5 }
    love.graphics.setNewFont(16)
end

function love.update(dt)
    angle = angle + 0.03
end

function love.draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

    local rotationZ = {
        { math.cos(angle), -math.sin(angle), 0 },
        { math.sin(angle), math.cos(angle), 0 },
        { 0, 0, 1 },
    }
    local rotationX = {
        { 1, 0, 0 },
        { 0, math.cos(angle), -math.sin(angle) },
        { 0, math.sin(angle), math.cos(angle) },
    }
    local rotationY = {
        { math.cos(angle), 0, math.sin(angle) },
        { 0, 1, 0 },
        { -math.sin(angle), 0, math.cos(angle) },
    }

    local projected = {}

    for i = 1, #points do
        local rotated = matrix.matmul(rotationY, points[i])
        rotated = matrix.matmul(rotationX, rotated)
        rotated = matrix.matmul(rotationZ, rotated)
        if rotated == nil then
            print("Error: rotationZ resulted in nil")
            goto continue
        end
        if rotated.z == nil then
            print("Error: rotated.z is nil")
            goto continue
        end
        local distance = 2
        local z = 1 / (distance - rotated.z)
        local projection = {
            { z, 0, 0 },
            { 0, z, 0 },
        }
        local Projected2d = matrix.matmul(projection, rotated)

        if Projected2d then
            Projected2d.x = Projected2d.x * 200
            Projected2d.y = Projected2d.y * 200
            projected[i] = Projected2d
        end
        ::continue::
    end

    for i = 1, #projected do
        love.graphics.setColor(1, 1, 1)
        love.graphics.circle("fill", projected[i].x, projected[i].y, 8)
    end

    -- Connecting
    for i = 1, 4 do
        connect(i, (i % 4) + 1, projected)
        connect(i + 4, ((i % 4) + 1) + 4, projected)
        connect(i, i + 4, projected)
    end
end

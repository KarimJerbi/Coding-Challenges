-- #015 Fractal Tree Array - Karim Jerbi(@KarimJerbi)

local vector = {}

function vector.new(x, y)
    return { x = x or 0, y = y or 0 }
end

function vector.add(v1, v2)
    return { x = v1.x + v2.x, y = v1.y + v2.y }
end

function vector.sub(v1, v2)
    return { x = v1.x - v2.x, y = v1.y - v2.y }
end

function vector.mult(v, scalar)
    return { x = v.x * scalar, y = v.y * scalar }
end

function vector.rotate(v, angle)
    local cosA = math.cos(angle)
    local sinA = math.sin(angle)
    local newX = v.x * cosA - v.y * sinA
    local newY = v.x * sinA + v.y * cosA
    return { x = newX, y = newY }
end

function vector.copy(v)
    -- Ensure v exists before trying to copy
    if v then
      return { x = v.x, y = v.y }
    else
      return { x = 0, y = 0 } -- Or handle error appropriately
    end
end

return vector

function VecSub(v1, v2)
    return { x = v1.x - v2.x, y = v1.y - v2.y }
end

function VecAdd(v1, v2)
    return { x = v1.x + v2.x, y = v1.y + v2.y }
end

function VecMult(v, scalar)
    return { x = v.x * scalar, y = v.y * scalar }
end

function VecDiv(v, scalar)
    if scalar == 0 then return { x = 0, y = 0 } end
    return { x = v.x / scalar, y = v.y / scalar }
end

function VecMag(v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

function VecDot(v1, v2)
    return v1.x * v2.x + v1.y * v2.y
end

function VecCopy(v)
    return { x = v.x, y = v.y }
end
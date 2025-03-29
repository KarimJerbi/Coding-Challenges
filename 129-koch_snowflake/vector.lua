local Vec = {}
function Vec.new(x, y)
  return {x = x or 0, y = y or 0}
end

function Vec.copy(v)
  return {x = v.x, y = v.y}
end

function Vec.add(v1, v2)
  return {x = v1.x + v2.x, y = v1.y + v2.y}
end

function Vec.sub(v1, v2)
  return {x = v1.x - v2.x, y = v1.y - v2.y}
end

function Vec.div(v, scalar)
  if scalar == 0 then
    error("Division by zero")
  end
  return {x = v.x / scalar, y = v.y / scalar}
end

function Vec.rotate(v, angle)
  local cosA = math.cos(angle)
  local sinA = math.sin(angle)
  local x_new = v.x * cosA - v.y * sinA
  local y_new = v.x * sinA + v.y * cosA
  return {x = x_new, y = y_new}
end

function Vec.dist(v1, v2)
    local dx = v2.x - v1.x
    local dy = v2.y - v1.y
    return math.sqrt(dx*dx + dy*dy)
end
return Vec
-- #129 Koch Snowflake - Karim Jerbi (@KarimJerbi)

local Segment = require('segment')

local segments = {}
local initial_y_offset = 100
local generation_count = 0
local max_generations = 6 -- Maximum number of generations allowed to prevent crashes

function love.load()
    love.window.setMode(600, 800)
    love.window.setTitle('Koch Fractal Snowflake')

    local function vec_new(x, y) return {x = x or 0, y = y or 0} end
    local function vec_dist(v1, v2)
        local dx = v2.x - v1.x
        local dy = v2.y - v1.y
        return math.sqrt(dx*dx + dy*dy)
    end

    local a = vec_new(0, 100)
    local b = vec_new(600, 100)

    -- third point 'c' for an equilateral triangle
    local len = vec_dist(a, b)
    local h = len * math.sqrt(3) / 2
    local c = vec_new(300, 100 + h)

    local s1 = Segment:new(a, b)
    local s2 = Segment:new(b, c)
    local s3 = Segment:new(c, a)

    table.insert(segments, s1)
    table.insert(segments, s2)
    table.insert(segments, s3)

end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if generation_count < max_generations then
            generation_count = generation_count + 1
            local nextGeneration = {}

            for i, current_segment in ipairs(segments) do
                local children = current_segment:generate()
                for j, child in ipairs(children) do
                    table.insert(nextGeneration, child)
                end
            end
            -- replace the current segments with new ones
            segments = nextGeneration
        end
    end
end

function love.draw()
    love.graphics.translate(0, initial_y_offset)

    love.graphics.setColor(1, 1, 1)

    for i, s in ipairs(segments) do
        s:show()
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Generation: " .. generation_count, 10, 10)
end

function love.keypressed(key)
    if key == 'r' then
        love.event.quit("restart")
    end
end

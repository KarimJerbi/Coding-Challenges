-- #015 Fractal Tree Array - Karim Jerbi(@KarimJerbi)

local Branch = require("branch")
local vector = require("vector")

local tree = {}
local leaves = {}
local count = 0
local width, height
local jitterEnabled = true
local Frame_jitter = {} -- Stores {dx, dy} keyed by vector reference

function love.load()
    width = 400
    height = 400
    love.window.setTitle("Fractal Tree Array")
    love.math.setRandomSeed(os.time())

    local startNode = vector.new(width / 2, height)
    local firstEndNode = vector.new(width / 2, height - 100)

    local root = Branch.new(startNode, firstEndNode)

    tree = {root}
    leaves = {}
    count = 0
    Frame_jitter = {}
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and presses == 1 then
        local branches_to_add = {}
        for i = #tree, 1, -1 do
            local current_branch = tree[i]
            if not current_branch.finished then
                table.insert(branches_to_add, current_branch:branchA())
                table.insert(branches_to_add, current_branch:branchB())
                current_branch.finished = true
            end
        end
        for i = 1, #branches_to_add do
            table.insert(tree, branches_to_add[i])
        end

        count = count + 1

        if count == 6 then
            for i = 1, #tree do
                local current_branch = tree[i]
                if not current_branch.finished then
                    local leaf_pos = vector.copy(current_branch.ending)
                    table.insert(leaves, leaf_pos)
                end
            end
        end
    end
end

function love.update(dt)
    Frame_jitter = {} -- clear previous frame's offsets
    if jitterEnabled then
        for i = 1, #tree do
            local branch = tree[i]
            local jitterX = love.math.random() * 2 - 1.0
            local jitterY = love.math.random() * 2 - 1.0
            Frame_jitter[branch.ending] = { dx = jitterX, dy = jitterY }
        end
    end

    for i = 1, #leaves do
        leaves[i].y = leaves[i].y + love.math.random() * 2
    end
end

function love.draw()
    love.graphics.clear(love.graphics.getBackgroundColor())

    -- Debug
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print("Jitter: " .. (jitterEnabled and "Enabled" or "Disabled"), 10, 10)
    love.graphics.print("Iterations: " .. count, 10, 25)

    -- Draw all branches
    for i = 1, #tree do
        local jitter_map = jitterEnabled and Frame_jitter or {}
        love.graphics.setColor(1, 1, 1, 1)
        local offset_begin = {}
        local offset_end = {}
        if tree[i].origin_ref and jitter_map[tree[i].origin_ref] then
            offset_begin = jitter_map[tree[i].origin_ref]
        else
            offset_begin = {dx = 0, dy = 0}
        end

        if jitter_map[tree[i].ending] then
            offset_end = jitter_map[tree[i].ending]
        else
            offset_end = {dx = 0, dy = 0}
        end

        love.graphics.line(tree[i].begin.x + offset_begin.dx, tree[i].begin.y + offset_begin.dy, tree[i].ending.x + offset_end.dx, tree[i].ending.y + offset_end.dy)
    end

    -- Draw leaves
    if #leaves > 0 then
        love.graphics.setColor(1, 0, 0.42, 0.42)
        for i = 1, #leaves do
            local leaf = leaves[i]
            love.graphics.ellipse("fill", leaf.x, leaf.y, 4, 4)
        end
    end
end

function love.keypressed(key)
    if key == 'r' then
          love.load()
    elseif key == 'j' then
        jitterEnabled = not jitterEnabled
    elseif key == 'escape' then
        love.event.quit()
    end
end

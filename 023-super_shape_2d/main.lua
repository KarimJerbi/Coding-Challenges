-- #023 Super Shape - Karim Jerbi (@KarimJerbi)

local n1 = 0.3
local n2 = 0.3
local n3 = 0.3
local m = 5   -- modifier value
local a = 1
local b = 1

local slider = {
    x = 50,
    y = 30,
    w = 300,
    h = 10,
    minVal = 0,
    maxVal = 10,
    value = m,       -- current value
    handleW = 8,     -- width of the draggable handle
    handleH = 20,    -- height of the draggable handle
    handleX = 0,     -- handle x position
    isDragging = false
}

-- map function for using osc
-- local osc = 0
local function map(value, start1, stop1, start2, stop2)
    -- Avoid division by zero
    if start1 == stop1 then return start2 end
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1))
end

function slider:updateHandlePosition()
    local normalizedValue = (self.value - self.minVal) / (self.maxVal - self.minVal)
    self.handleX = self.x + normalizedValue * self.w
end

function slider:updateValueFromMouse(mouseX)
    local clampedX = math.max(self.x, math.min(self.x + self.w, mouseX))
    local normalizedPosition = (clampedX - self.x) / self.w
    self.value = self.minVal + normalizedPosition * (self.maxVal - self.minVal)
    self:updateHandlePosition()
    m = self.value
end

function slider:draw()
    -- slider track
    love.graphics.setColor(0.35, 0.35, 0.35)
    love.graphics.rectangle("fill", self.x, self.y + (self.handleH - self.h) / 2, self.w, self.h, 3, 3)

    -- slider handle
    if self.isDragging then
        love.graphics.setColor(1, 0.3, 0.3)
    else
        love.graphics.setColor(1, 1, 1)
    end

    love.graphics.rectangle("fill", self.handleX - self.handleW / 2, self.y, self.handleW, self.handleH, 2, 2)

    -- Draw the value text
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(string.format("m: %.2f", self.value), self.x, self.y + self.handleH + 5, self.w, "center")
end

function slider:isMouseOverHandle(mx, my)
    local hx1 = self.handleX - self.handleW / 2
    local hy1 = self.y
    local hx2 = hx1 + self.handleW
    local hy2 = hy1 + self.handleH
    return mx >= hx1 and mx <= hx2 and my >= hy1 and my <= hy2
end

local function supershape(theta)
    local part1 = (1 / a) * math.cos((theta * m) / 4)
    part1 = math.abs(part1)
    part1 = math.pow(part1, n2)

    local part2 = (1 / b) * math.sin((theta * m) / 4)
    part2 = math.abs(part2)
    part2 = math.pow(part2, n3)

    local power_base = part1 + part2
    if power_base == 0 then
        if (1/n1) < 0 then return math.huge end
    end

    local part3 = math.pow(power_base, 1 / n1)

    if part3 == 0 then
        return 0
    end

    return 1 / part3
end

local radius = 100
local total = 200
local increment = (2 * math.pi) / total

function love.load()
    love.window.setTitle('Super Shape 2D')
    slider:updateHandlePosition()
end

function love.update(dt)
    -- osc = osc + 0.02
    -- m = map(math.sin(osc), -1, 1, 0, 10)

    if slider.isDragging then
        local mx = love.mouse.getX()
        slider:updateValueFromMouse(mx)
    end

end

function love.mousepressed(x, y, button)
    if button == 1 then
        if slider:isMouseOverHandle(x, y) then
            slider.isDragging = true
        -- allow clicking anywhere on the track to jump the handle
        elseif x >= slider.x and x <= slider.x + slider.w and y >= slider.y and y <= slider.y + slider.handleH then
            slider.isDragging = true
            slider:updateValueFromMouse(x)
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        if slider.isDragging then
            slider.isDragging = false
        end
    end
end

function love.draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    -- slider
    slider:draw()

    -- supershape on frame
    local vertices = {}
    for i = 0, total - 1 do
        local angle = i * increment
        local r = supershape(angle)
        local x = radius * r * math.cos(angle)
        local y = radius * r * math.sin(angle)
        table.insert(vertices, x)
        table.insert(vertices, y)
    end
    love.graphics.push()
    love.graphics.translate(width / 2, height / 2)

    love.graphics.setColor(1, 1, 1)
    love.graphics.polygon("line", vertices)

    love.graphics.pop()

end

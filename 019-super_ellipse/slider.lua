-- #019 Super Ellipse - Karim Jerbi(@KarimJerbi)

local Slider = {}
Slider.__index = Slider

function Slider:new(x, y, w, h, minVal, maxVal, initialValue, handleW, handleH)
    local self = setmetatable({}, Slider)

    self.x = x or 50
    self.y = y or 30
    self.w = w or 300
    self.h = h or 10
    self.minVal = minVal or 0
    self.maxVal = maxVal or 10
    self.value = initialValue or (minVal + maxVal) / 2

    self.handleW = handleW or 8
    self.handleH = handleH or 20
    self.handleX = 0
    self.isDragging = false

    self:updateHandlePosition()

    return self
end

function Slider:updateHandlePosition()
    if self.maxVal == self.minVal then
        self.handleX = self.x
        return
    end
    local normalizedValue = (self.value - self.minVal) / (self.maxVal - self.minVal)
    self.handleX = self.x + normalizedValue * self.w
end

-- update the slider value based on mouse position (during drag)
function Slider:updateValueFromMouse(mouseX)
    local clampedX = math.max(self.x, math.min(self.x + self.w, mouseX))
    local normalizedPosition = 0
    if self.w ~= 0 then
        normalizedPosition = (clampedX - self.x) / self.w
    end
    local newValue = self.minVal + normalizedPosition * (self.maxVal - self.minVal)

    if math.abs(newValue - self.value) > 1e-6 then -- Check against epsilon
        self.value = newValue
        self:updateHandlePosition()
    end
end

function Slider:draw()
    -- track
    love.graphics.setColor(0.35, 0.35, 0.35)
    love.graphics.rectangle("fill", self.x, self.y + (self.handleH - self.h) / 2, self.w, self.h, 3, 3)

    -- handle
    if self.isDragging then
        love.graphics.setColor(1, 0.3, 0.3)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.rectangle("fill", self.handleX - self.handleW / 2, self.y, self.handleW, self.handleH, 2, 2)

    -- value
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(string.format("%.2f", self.value), self.x, self.y + self.handleH + 5, self.w, "center")
end

-- check if a point is inside the handle's bounds
function Slider:isMouseOverHandle(mx, my)
    local hx1 = self.handleX - self.handleW / 2
    local hy1 = self.y
    local hx2 = hx1 + self.handleW
    local hy2 = hy1 + self.handleH
    return mx >= hx1 and mx <= hx2 and my >= hy1 and my <= hy2
end

function Slider:handleMousePressed(x, y, button)
    if button == 1 then
        if self:isMouseOverHandle(x, y) then
            self.isDragging = true
            self:updateValueFromMouse(x)
            return true
        -- clicking track to jump handle
        elseif x >= self.x and x <= self.x + self.w and y >= self.y and y <= self.y + self.handleH then
            self.isDragging = true
            self:updateValueFromMouse(x)
            return true
        end
    end
    return false
end

function Slider:handleMouseReleased(x, y, button)
    if button == 1 and self.isDragging then
        self.isDragging = false
        return true
    end
    return false
end

function Slider:update(dt)
    if self.isDragging then
        local mx = love.mouse.getX()
        self:updateValueFromMouse(mx)
    end
end

return Slider

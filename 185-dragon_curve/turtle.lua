-- #185 Tic Tac Toe - Karim Jerbi(@KarimJerbi)

Turtle = {}
Turtle.__index = Turtle

function Turtle:new(length, angle)
    local self = setmetatable({}, Turtle)
    self:initialize(length, angle)
    return self
end

function Turtle:initialize(length, angle)
    self.length = length
    self.angle = angle
    self.end_step = 0
end

local function hslToRgb(h, s, l)
    local r, g, b

    if s == 0 then
        r = l
        g = l
        b = l
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1/6 then return p + (q - p) * 6 * t end
            if t < 1/2 then return q end
            if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
            return p
        end

        local q = l < 0.5 and l * (1 + s) or l + s - l * s
        local p = 2 * l - q
        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end

    return r, g, b
end


function Turtle:renderStep(sentence)
    local h = 0
    self.end_step = self.end_step + 200
    for i = 1, math.min(self.end_step, #sentence) do
        local c = string.sub(sentence, i, i)
        if c == "F" then
            local r, g, b = hslToRgb(h, 1, 0.5)
            love.graphics.setColor(r, g, b, 1)
            love.graphics.setLineWidth(1.5)
            love.graphics.line(0, 0, 0, -self.length)
            love.graphics.translate(0, -self.length)
            h = h + 0.0001
            if h > 1 then h = 0 end
        elseif c == "+" then
            love.graphics.rotate(self.angle)
        elseif c == "-" then
            love.graphics.rotate(-self.angle)
        elseif c == "[" then
            love.graphics.push()
        elseif c == "]" then
            love.graphics.pop()
        end
    end
end

function Turtle:render(sentence)
    local h = 0
    for i = 1, #sentence do
        local c = string.sub(sentence, i, i)
        if c == "F" then
            local r, g, b = hslToRgb(h, 1, 0.5)
            love.graphics.setColor(r, g, b, 1)
            love.graphics.setLineWidth(1)
            love.graphics.line(0, 0, 0, -self.length)
            love.graphics.translate(0, -self.length)
            h = h + 0.0001
            if h > 1 then h = 0 end
        elseif c == "+" then
                love.graphics.rotate(self.angle)
        elseif c == "-" then
                love.graphics.rotate(-self.angle)
        elseif c == "[" then
                love.graphics.push()
        elseif c == "]" then
                love.graphics.pop()
        end
    end
end
return Turtle

-- #185 Elastic Collisions - Karim Jerbi(@KarimJerbi)

local Particle = {}
Particle.__index = Particle

require('vector')

function Particle:new(x, y)
    local instance = setmetatable({}, Particle)

    instance.position = { x = x, y = y }

    local angle = love.math.random() * 2 * math.pi
    local speed = love.math.random(4, 12)
    instance.velocity = { x = math.cos(angle) * speed, y = math.sin(angle) * speed }

    instance.acceleration = { x = 0, y = 0 }
    instance.mass = love.math.random(8, 16)
    instance.r = math.sqrt(instance.mass) * 15

    return instance
end

-- Not used in this specific example main, but included for completeness
function Particle:applyForce(force)
    local f = VecCopy(force)
    f = VecDiv(f, self.mass)
    self.acceleration = VecAdd(self.acceleration, f)
end

function Particle:update()
    self.velocity = VecAdd(self.velocity, self.acceleration)
    self.position = VecAdd(self.position, self.velocity)
    -- reset acceleration
    self.acceleration = { x = 0, y = 0 }
end

function Particle:collide(other)
    local impactVector = VecSub(other.position, self.position)
    -- d is distance
    local d = VecMag(impactVector)
    local minDist = self.r + other.r

    if d < minDist then
        local overlap = minDist - d
        local pushDir
        if d == 0 then -- if overlapping, push away
           pushDir = {x=1, y=0}
        else
           pushDir = VecDiv(impactVector, d)
        end

        local pushAmount = overlap * 0.5 -- push by half overlap
        local pushVector = VecMult(pushDir, pushAmount)

        self.position = VecSub(self.position, pushVector)
        other.position = VecAdd(other.position, pushVector)

        -- distance and impact Vector based on corrected positions
        impactVector = VecSub(other.position, self.position)
        d = VecMag(impactVector)
        -- If d is still zero after push (unlikely but possible with floating point), exit
        if d == 0 then return end

        -- elastic collision response
        local mSum = self.mass + other.mass
        local vDiff = VecSub(other.velocity, self.velocity)

    
        -- vaf = va - 2*mb/(ma+mb) * dot(va-vb, xa-xb) / |xa-xb|^2 * (xa-xb)
        -- vbf = vb - 2*ma/(ma+mb) * dot(vb-va, xb-xa) / |xb-xa|^2 * (xb-xa)

        local dotProduct = VecDot(vDiff, impactVector)
        local commonFactor = (2 / mSum) * (dotProduct / (d * d))

        -- Particle A
        local deltaVA_scalar = other.mass * commonFactor
        local deltaVA_Vector = VecMult(impactVector, deltaVA_scalar)
        self.velocity = VecAdd(self.velocity, deltaVA_Vector)

        -- Particle B
        local deltaVB_scalar = -self.mass * commonFactor
        local deltaVB_Vector = VecMult(impactVector, deltaVB_scalar)
        other.velocity = VecAdd(other.velocity, deltaVB_Vector)

    end
end

function Particle:edges()
    local W = love.graphics.getWidth()
    local H = love.graphics.getHeight()

    if self.position.x > W - self.r then
        self.position.x = W - self.r
        self.velocity.x = self.velocity.x * -1
    elseif self.position.x < self.r then
        self.position.x = self.r
        self.velocity.x = self.velocity.x * -1
    end

    if self.position.y > H - self.r then
        self.position.y = H - self.r
        self.velocity.y = self.velocity.y * -1
    elseif self.position.y < self.r then
        self.position.y = self.r
        self.velocity.y = self.velocity.y * -1
    end
end

function Particle:show()
    love.graphics.setColor(0.5, 0.2, 0.5)
    love.graphics.circle("fill", self.position.x, self.position.y, self.r)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setLineWidth(2)
    love.graphics.circle("line", self.position.x, self.position.y, self.r)
end

return Particle
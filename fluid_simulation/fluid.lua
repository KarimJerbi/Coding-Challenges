-- #132 Fluid Simulation - Karim Jerbi (@KarimJerbi) 01-2025

local fluid_utils = require("fluid_utils")

local Fluid = {}
Fluid.__index = Fluid

local N = 256
local SCALE = 4

function Fluid.new(dt, diffusion, viscosity)
  local self = setmetatable({}, Fluid)
  self.size = N
  self.dt = dt
  self.diff = diffusion
  self.visc = viscosity

  self.s = {}
  self.density = {}
  self.Vx = {}
  self.Vy = {}
  self.Vx0 = {}
  self.Vy0 = {}

  for i = 1, N * N do
    self.s[i] = 0
    self.density[i] = 0
    self.Vx[i] = 0
    self.Vy[i] = 0
    self.Vx0[i] = 0
    self.Vy0[i] = 0
  end

  return self
end

function Fluid:IX(x, y)
    return x + y * N
end

function Fluid:step()
  local N = self.size
  local visc = self.visc
  local diff = self.diff
  local dt = self.dt
  local Vx = self.Vx
  local Vy = self.Vy
  local Vx0 = self.Vx0
  local Vy0 = self.Vy0
  local s = self.s
  local density = self.density

  fluid_utils.diffuse(1, Vx0, Vx, visc, dt)
  fluid_utils.diffuse(2, Vy0, Vy, visc, dt)

  fluid_utils.project(Vx0, Vy0, Vx, Vy)

  fluid_utils.advect(1, Vx, Vx0, Vx0, Vy0, dt)
  fluid_utils.advect(2, Vy, Vy0, Vx0, Vy0, dt)

  fluid_utils.project(Vx, Vy, Vx0, Vy0)
  fluid_utils.diffuse(0, s, density, diff, dt)
  fluid_utils.advect(0, density, s, Vx, Vy, dt)
end

function Fluid:addDensity(x, y, amount)
  local index = self:IX(x, y)
  self.density[index] = (self.density[index] or 0) + amount
end

function Fluid:addVelocity(x, y, amountX, amountY)
  local index = self:IX(x, y)
  self.Vx[index] = (self.Vx[index] or 0) + amountX
  self.Vy[index] = (self.Vy[index] or 0) + amountY
end


function Fluid:hsbToRgb(h, s, b)
  local h_i = math.floor(h * 6)
  local f = h * 6 - h_i
  local p = b * (1 - s)
  local q = b * (1 - f * s)
  local t = b * (1 - (1 - f) * s)

  local r, g, bb = 0, 0, 0
  if h_i == 0 then
    r, g, bb = b, t, p
  elseif h_i == 1 then
    r, g, bb = q, b, p
  elseif h_i == 2 then
    r, g, bb = p, b, t
  elseif h_i == 3 then
    r, g, bb = p, q, b
  elseif h_i == 4 then
    r, g, bb = t, p, b
  elseif h_i == 5 then
    r, g, bb = b, p, q
  end

  return r, g, bb
end

function Fluid:renderD()
    for i = 0, N - 1 do
        for j = 0, N - 1 do
            local x = i * SCALE
            local y = j * SCALE
            local d = self.density[self:IX(i+1, j+1)] or 0
            
            -- Map density to hue (0 to 1)
            local hue = (d / 255) % 1
            local r, g, b = self:hsbToRgb(hue, 1, 1)
            
            love.graphics.setColor(r, g, b)
            love.graphics.rectangle('fill', x, y, SCALE, SCALE)
        end
    end
end


function Fluid:renderV()
    for i = 0, N - 1 do
        for j = 0, N - 1 do
            local x = i * SCALE
            local y = j * SCALE
            local vx = self.Vx[self:IX(i+1, j+1)]
            local vy = self.Vy[self:IX(i+1, j+1)]
            love.graphics.setColor(0, 0, 0)
            if not (math.abs(vx) < 0.1 and math.abs(vy) <= 0.1) then
                love.graphics.line(x, y, x + vx * SCALE, y + vy * SCALE)
            end
        end
    end
end

return Fluid

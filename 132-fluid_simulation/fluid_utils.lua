-- #132 Fluid Simulation - Karim Jerbi (@KarimJerbi) 01-2025

local N = 256 -- resolution
local iter = 16

local function IX(x, y)
    return x + y * N
end

local fluid_utils = {}

function fluid_utils.diffuse(b, x, x0, diff, dt)
    local a = dt * diff * (N - 2) * (N - 2)
    fluid_utils.lin_solve(b, x, x0, a, 1 + 6 * a)
end

function fluid_utils.lin_solve(b, x, x0, a, c)
    local cRecip = 1.0 / c
    for t = 1, iter do
        for j = 2, N - 1 do
            for i = 2, N - 1 do
                x[IX(i, j)] = (x0[IX(i, j)] +
                                 a * (
                                   (x[IX(i + 1, j)] or 0) +
                                   (x[IX(i - 1, j)] or 0) +
                                   (x[IX(i, j + 1)] or 0) +
                                   (x[IX(i, j - 1)] or 0)
                                 )
                             ) * cRecip
            end
        end
         fluid_utils.set_bnd(b, x)
    end
end

function fluid_utils.project(velocX, velocY, p, div)
    for j = 2, N - 1 do
        for i = 2, N - 1 do
            div[IX(i, j)] = (-0.5 * (
                (velocX[IX(i + 1, j)] or 0) -
                (velocX[IX(i - 1, j)] or 0) +
                (velocY[IX(i, j + 1)] or 0) -
                (velocY[IX(i, j - 1)] or 0)
                )) / N

            p[IX(i, j)] = 0
        end
    end

    fluid_utils.set_bnd(0, div)
    fluid_utils.set_bnd(0, p)
    fluid_utils.lin_solve(0, p, div, 1, 6)

    for j = 2, N - 1 do
        for i = 2, N - 1 do
            velocX[IX(i, j)] = (velocX[IX(i, j)] or 0) - 0.5 * ((p[IX(i + 1, j)] or 0) - (p[IX(i - 1, j)] or 0)) * N
            velocY[IX(i, j)] = (velocY[IX(i, j)] or 0) - 0.5 * ((p[IX(i, j + 1)] or 0) - (p[IX(i, j - 1)] or 0)) * N
        end
    end

    fluid_utils.set_bnd(1, velocX)
    fluid_utils.set_bnd(2, velocY)
end

function fluid_utils.advect(b, d, d0, velocX, velocY, dt)
    local i0, i1, j0, j1
    local dtx = dt * (N - 2)
    local dty = dt * (N - 2)

    local s0, s1, t0, t1
    local tmp1, tmp2, x, y
    local Nfloat = N - 2

    for j = 2, N - 1 do
        for i = 2, N - 1 do
            tmp1 = dtx * (velocX[IX(i, j)] or 0)
            tmp2 = dty * (velocY[IX(i, j)] or 0)
            x = i - 1 - tmp1
            y = j - 1 - tmp2

            if x < 0.5 then
                x = 0.5
            end
            if x > Nfloat + 0.5 then
                x = Nfloat + 0.5
            end
            i0 = math.floor(x)
            i1 = i0 + 1
            if y < 0.5 then
                y = 0.5
            end
            if y > Nfloat + 0.5 then
                y = Nfloat + 0.5
            end
            j0 = math.floor(y)
            j1 = j0 + 1

            s1 = x - i0
            s0 = 1.0 - s1
            t1 = y - j0
            t0 = 1.0 - t1

            d[IX(i, j)] = s0 * (
                t0 * (d0[IX(i0 + 1, j0 + 1)] or 0) + t1 * (d0[IX(i0 + 1, j1 + 1)] or 0)
              ) +
              s1 * (
                t0 * (d0[IX(i1 + 1, j0 + 1)] or 0) + t1 * (d0[IX(i1 + 1, j1 + 1)] or 0)
            )
        end
    end
    fluid_utils.set_bnd(b, d)
end


function fluid_utils.set_bnd(b, x)
    for i = 2, N - 1 do
        x[IX(i, 1)] = b == 2 and -(x[IX(i, 2)] or 0) or (x[IX(i, 2)] or 0)
        x[IX(i, N)] = b == 2 and -(x[IX(i, N - 1)] or 0) or (x[IX(i, N - 1)] or 0)
    end
    for j = 2, N - 1 do
        x[IX(1, j)] = b == 1 and -(x[IX(2, j)] or 0) or (x[IX(2, j)] or 0)
        x[IX(N, j)] = b == 1 and -(x[IX(N - 1, j)] or 0) or (x[IX(N - 1, j)] or 0)
    end

    x[IX(1, 1)] = 0.5 * ((x[IX(2, 1)] or 0) + (x[IX(1, 2)] or 0))
    x[IX(1, N)] = 0.5 * ((x[IX(2, N)] or 0) + (x[IX(1, N - 1)] or 0))
    x[IX(N, 1)] = 0.5 * ((x[IX(N - 1, 1)] or 0) + (x[IX(N, 2)] or 0))
    x[IX(N, N)] = 0.5 * ((x[IX(N - 1, N)] or 0) + (x[IX(N, N - 1)] or 0))
end

return fluid_utils

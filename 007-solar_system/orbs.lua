-- #007 Solar System 2D - Karim Jerbi(@KarimJerbi)
-- orbs.lua : contains code related to orbs: stars,planets and moons

function NewOrb(r,d,l,o)
    local orb = {}
    orb.r = r
    orb.a = love.math.random(2*math.pi)
    orb.d = d
    orb.o = o
    orb.orbs = {}
    orb.level  = l
    if l < 3 then -- Recursive Spawning
        for i=1,love.math.random(2,4) do 
            r = orb.r/(l*2)
            d = love.math.random(75, 150)
            o = love.math.random(-0.01, 0.01)
            table.insert(orb.orbs,NewOrb(r, d/l,l+1,o))
        end
    end
    return orb
end

function Orbit(orb)
    orb.a = orb.a + orb.o
    if #orb.orbs ~= 0 then -- Recursive updating
        for _,orbiter in ipairs(orb.orbs) do
            Orbit(orbiter)
        end
    end
end

function DrawOrb(orb)
    love.graphics.setColor(1, 1, 1, 0.2)
    love.graphics.push('all')
    love.graphics.rotate(orb.a)
    love.graphics.translate(orb.d, 0)
    love.graphics.ellipse('fill', 0, 0, orb.r, orb.r)
    if #orb.orbs ~= 0 then -- Recursive drawing
        for _,orbiter in ipairs(orb.orbs) do
            DrawOrb(orbiter)
        end
    end
    love.graphics.pop()
end
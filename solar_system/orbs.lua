-- #007 Solar System 2D - Karim Jerbi(@KarimJerbi)
-- orbs.lua : contains code related to orbs: stars,planets and moons

random = love.math.random 

function newOrb(r,d,l,o)
	local orb = {}
	orb.r = r
	orb.a = random(2*math.pi)
	orb.d = d
	orb.o = o
	orb.orbs = {}
	orb.level  = l
	if l < 3 then -- Recursive Spawning
		for i=1,random(2,4) do 
			r = orb.r/(l*2)
			d = random(75, 150)
			o = random(-0.01, 0.01)
			table.insert(orb.orbs,newOrb(r, d/l,l+1,o))
		end
	end
	return orb
end

function orbit(orb)
	orb.a = orb.a + orb.o
	if #orb.orbs ~= 0 then -- Recursive updating
		for _,orbiter in ipairs(orb.orbs) do
			orbit(orbiter)
		end
	end
end

function drawOrb(orb)
	love.graphics.setColor(1, 1, 1, 0.2)
	love.graphics.push('all')
	love.graphics.rotate(orb.a)
	love.graphics.translate(orb.d, 0)
	love.graphics.ellipse('fill', 0, 0, orb.r, orb.r)
	if #orb.orbs ~= 0 then -- Recursive drawing
		for _,orbiter in ipairs(orb.orbs) do
			drawOrb(orbiter)
		end
	end
	love.graphics.pop()
end
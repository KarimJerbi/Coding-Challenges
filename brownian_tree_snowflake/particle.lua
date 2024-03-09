-- #127 Brownian Motion Snowflake - Karim Jerbi(@KarimJerbi)
-- particle.lua : contains code related to the particle object

function newParticle(radius,angle)
	particle = {}
	particle.x = math.cos(angle) * radius
	particle.y = math.sin(angle) * radius
	particle.r = 3
	particle.f = particle.x < 1
	return particle
end

function updateParticle(part)
	part.x = part.x - 1
	part.y = part.y + love.math.random(-5,5) -- random walker
	part.f = part.x < 1
end

function intersects(current, parts)
	r = false
	for _, part in ipairs(parts) do
		local d = math.sqrt((part.x-current.x)^2 + (part.y-current.y)^2)
		if d < (current.r*3) then -- sensor
			r = true
			break
		end
	end

	return r
end

function drawParticles(parts)
	for i, part in ipairs(parts) do
		love.graphics.ellipse('fill',part.x,part.y,part.r,part.r)
	end
end
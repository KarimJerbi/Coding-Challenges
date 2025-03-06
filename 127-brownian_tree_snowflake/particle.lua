-- #127 Brownian Motion Snowflake - Karim Jerbi(@KarimJerbi)
-- particle.lua : contains code related to the particle object

function NewParticle(radius,angle)
	local particle = {}
	particle.x = math.cos(angle) * radius
	particle.y = math.sin(angle) * radius
	particle.r = 3
	particle.f = particle.x < 1
	return particle
end

function UpdateParticle(part)
	part.x = part.x - 1
	part.y = part.y + love.math.random(-5,5) -- random walker
	part.f = part.x < 1
end

function Intersects(Current, parts)
	local r = false
	for _, part in ipairs(parts) do
		local d = math.sqrt((part.x-Current.x)^2 + (part.y-Current.y)^2)
		if d < (Current.r*3) then -- sensor
			r = true
			break
		end
	end

	return r
end

function DrawParticles(parts)
	for i, part in ipairs(parts) do
		love.graphics.ellipse('fill',part.x,part.y,part.r,part.r)
	end
end
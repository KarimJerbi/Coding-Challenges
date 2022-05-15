-- #127 Brownian Motion Snowflake - Karim Jerbi(@apolius)

love.window.setTitle('Brownian Motion Snowflake')
function love.load()
	love.window.setFullscreen(true, "desktop")
	width, height = love.graphics.getDimensions()
	require('particle')
	snowflake = {}
	current = newParticle(width/2, 0)
	
end

function love.update()
	while current.f == false and not(intersects(current,snowflake)) do
		updateParticle(current)
	end
	if current.x < width/3 then
		table.insert(snowflake, current)
		current = newParticle(width/2, 0)
	end
	if love.keyboard.isDown('r') then
		snowflake = {}
		current = newParticle(width/2, 0)
	end
end

function love.draw()
	love.graphics.print(current.x,0,0)
	love.graphics.print(#snowflake,0,20)
	love.graphics.translate(width/2, height/2)
	love.graphics.rotate(math.pi/6)
	for i = 1, 6 do
		love.graphics.rotate(math.pi/3)
		love.graphics.ellipse('fill',current.x,current.y,current.r*2,current.r*2)
		drawParticles(snowflake)
		love.graphics.push()
		love.graphics.scale(1, -1)
		love.graphics.ellipse('fill',current.x,current.y,current.r*2,current.r*2)
		drawParticles(snowflake)
		love.graphics.pop()
	end
end

-- #127 Brownian Motion Snowflake - Karim Jerbi(@apolius)

love.window.setTitle('Brownian Motion Snowflake')
g = love.graphics
function love.load()
	love.window.setFullscreen(true, "desktop")
	height = g.getHeight()
	width = g.getWidth()
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
	g.print(current.x,0,0)
	g.print(#snowflake,0,20)
	g.translate(width/2, height/2)
	g.rotate(math.pi/6)
	for i = 1, 6 do
		g.rotate(math.pi/3)
		g.ellipse('fill',current.x,current.y,current.r*2,current.r*2)
		drawParticles(snowflake)
		g.push()
		g.scale(1, -1)
		g.ellipse('fill',current.x,current.y,current.r*2,current.r*2)
		drawParticles(snowflake)
		g.pop()
	end
end
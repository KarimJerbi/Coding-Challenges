-- #127 Brownian Motion Snowflake - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Brownian Motion Snowflake')
function love.load()
	love.window.setFullscreen(true, "desktop")
	Width, Height = love.graphics.getDimensions()
	require('particle')
	Snowflake = {}
	Current = NewParticle(Width/2, 0)
	
end

function love.update()
	while Current.f == false and not(Intersects(Current,Snowflake)) do
		UpdateParticle(Current)
	end
	if Current.x < Width/3 then
		table.insert(Snowflake, Current)
		Current = NewParticle(Width/2, 0)
	end
	if love.keyboard.isDown('r') then
		Snowflake = {}
		Current = NewParticle(Width/2, 0)
	end
end

function love.draw()
	love.graphics.print(Current.x,0,0)
	love.graphics.print(#Snowflake,0,20)
	love.graphics.translate(Width/2, Height/2)
	love.graphics.rotate(math.pi/6)
	for i = 1, 6 do
		love.graphics.rotate(math.pi/3)
		love.graphics.ellipse('fill',Current.x,Current.y,Current.r*2,Current.r*2)
		DrawParticles(Snowflake)
		love.graphics.push()
		love.graphics.scale(1, -1)
		love.graphics.ellipse('fill',Current.x,Current.y,Current.r*2,Current.r*2)
		DrawParticles(Snowflake)
		love.graphics.pop()
	end
end

-- #131 Bouncing DVD - Karim Jerbi(@KarimJerbi) 06-2019

function love.load()
	love.window.setTitle('Bouncing DVD')
	width, height = love.graphics.getDimensions()
	xSpeed = 2
	ySpeed = 2

	dvd = love.graphics.newImage("gfx/dvd.png")
	x = (width/2) + dvd:getWidth()
	y = (height/2) + dvd:getHeight()

	function randomColor()
		local r = love.math.random(0.392,1)
		local g = love.math.random(0.392,1)
		local b = love.math.random(0.392,1)
		love.graphics.setColor(r, g, b)
	end
end

function love.update()
	x = x + xSpeed
	y = y + ySpeed

	if (x + dvd:getWidth() >= width) then
		xSpeed = -xSpeed
		x = width - dvd:getWidth()
		randomColor()
	elseif (x <= 0) then
		xSpeed = -xSpeed
		x = 0
		randomColor()
	end

	if (y + dvd:getHeight() >= height) then
		ySpeed = -ySpeed
		y = height - dvd:getHeight()
		randomColor()
	elseif (y <= 0) then
		ySpeed = -ySpeed
		y = 0
		randomColor()
	end
end

function love.draw()
	love.graphics.draw(dvd, x, y)
end

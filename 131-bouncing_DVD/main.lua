-- #131 Bouncing DVD - Karim Jerbi(@KarimJerbi) 06-2019

function love.load()
	love.window.setTitle('Bouncing DVD')
	Width, Height = love.graphics.getDimensions()
	XSpeed = 2
	YSpeed = 2

	DVD = love.graphics.newImage("gfx/DVD.png")
	X = (Width/2) + DVD:getWidth()
	Y = (Height/2) + DVD:getHeight()

	function RandomColor()
		local r = love.math.random(0.392,1)
		local g = love.math.random(0.392,1)
		local b = love.math.random(0.392,1)
		love.graphics.setColor(r, g, b)
	end
end

function love.update()
	X = X + XSpeed
	Y = Y + YSpeed

	if (X + DVD:getWidth() >= Width) then
		XSpeed = -XSpeed
		X = Width - DVD:getWidth()
		RandomColor()
	elseif (X <= 0) then
		XSpeed = -XSpeed
		X = 0
		RandomColor()
	end

	if (Y + DVD:getHeight() >= Height) then
		YSpeed = -YSpeed
		Y = Height - DVD:getHeight()
		RandomColor()
	elseif (Y <= 0) then
		YSpeed = -YSpeed
		Y = 0
		RandomColor()
	end
end

function love.draw()
	love.graphics.draw(DVD, X, Y)
end

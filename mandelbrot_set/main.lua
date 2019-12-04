-- #021 Mandelbrot Set - Karim Jerbi(@apolius)
g = love.graphics
love.window.setTitle('Mandelbrot Set')
max = 100
zo,dx,dy = 1,0,0
width = g.getWidth()
height = g.getHeight()
pixels = love.image.newImageData(width, height)

function love.load()
	for i = 1, height-1 do 
		for j = 1, width-1 do
			real = (j -width/2) *4 /width
			imag = (i -height/2)*4 /width
			x = 0
			y = 0
			Js = 0
			while x*x + y*y < 4 and Js < max do
				NewX = x*x - y*y + real
				y = 2 * x * y + imag
				x = NewX
				Js = Js + 1
			end
			if Js < max then
				pixels:setPixel(j, i,Js/max,Js/max,Js/max)
			else
				pixels:setPixel(j,i,0,0,0)
			end
		end
	end
	set = love.graphics.newImage(pixels)
end

function love.update()
	if love.keyboard.isDown('q') then
		zo = zo +0.05
	end
	if love.keyboard.isDown('e') then
		zo = zo -0.05
	end
	if love.keyboard.isDown('a') then
		dx = dx +10
	end
	if love.keyboard.isDown('d') then
		dx = dx -10
	end
	if love.keyboard.isDown('w') then
		dy = dy +10
	end
	if love.keyboard.isDown('s') then
		dy = dy -10
	end
	if love.keyboard.isDown('x') then
		zo,dx,dy = 1,0,0
	end
end

function love.draw()
	g.scale(zo, zo)
	g.translate(dx, dy)
	g.draw(set,0,0)
end

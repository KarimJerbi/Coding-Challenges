-- #021 Mandelbrot Set - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Mandelbrot Set')
Max = 100
Zo,Dx,Dy = 1,0,0
Width = love.graphics.getWidth()
Height = love.graphics.getHeight()
Pixels = love.image.newImageData(Width, Height)

function love.load()
	for i = 1, Height-1 do 
		for j = 1, Width-1 do
			local real = (j -Width/2) *4 /Width
			local imag = (i -Height/2)*4 /Width
			local x = 0
			local y = 0
			Js = 0
			while x*x + y*y < 4 and Js < Max do
				NewX = x*x - y*y + real
				y = 2 * x * y + imag
				x = NewX
				Js = Js + 1
			end
			if Js < Max then
				Pixels:setPixel(j, i,Js/Max,Js/Max,Js/Max)
			else
				Pixels:setPixel(j,i,0,0,0)
			end
		end
	end
	Set = love.graphics.newImage(Pixels)
end

function love.update()
	if love.keyboard.isDown('q') then
		Zo = Zo +0.05
	end
	if love.keyboard.isDown('e') then
		Zo = Zo -0.05
	end
	if love.keyboard.isDown('a') then
		Dx = Dx +10
	end
	if love.keyboard.isDown('d') then
		Dx = Dx -10
	end
	if love.keyboard.isDown('w') then
		Dy = Dy +10
	end
	if love.keyboard.isDown('s') then
		Dy = Dy -10
	end
	if love.keyboard.isDown('x') then
		Zo,Dx,Dy = 1,0,0
	end
end

function love.draw()
	love.graphics.scale(Zo, Zo)
	love.graphics.translate(Dx, Dy)
	love.graphics.draw(Set,0,0)
end

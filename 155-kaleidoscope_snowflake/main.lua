-- #155 Kaleidoscope Snowflake - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Kaleidoscope Snowflake')
function love.load()
	love.window.setFullscreen(true)
	Width, Height = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest')
	Stats = true

	function NewStroke(PX,PY,X,Y,W,R,G,B,A)
		local stroke = {}
		stroke.PX, stroke.PY = PX,PY
		stroke.X, stroke.Y = X,Y
		stroke.W = W
		stroke.rgb = {R, G, B, A}
		return stroke
	end

	function DrawStrokes(strokes)
		for _,stroke in pairs(strokes) do
			love.graphics.setColor(stroke.rgb)
			love.graphics.setLineWidth(stroke.W)
			love.graphics.line(stroke.PX, stroke.PY,stroke.X, stroke.Y)
		end
	end

	PX,PY,X,Y = 0,0,0,0
	R,G,B,A = 1, 1 ,1, 1
	W = 4

	Snowflake = {}
	Current = {}
	
end

function love.update(dt)
	X,Y = love.mouse.getPosition()
	X = X - Width/2
	Y = Y - Height/2

	if love.mouse.isDown(1) then
		Current = NewStroke(PX,PY,X,Y,W,R,G,B,A)
		table.insert(Snowflake, Current)
	end

	-- stroke controls :
	if love.keyboard.isDown('R') and love.keyboard.isDown('up') and R<= 1 then
		R = R + dt/8
	end
	if love.keyboard.isDown('R') and love.keyboard.isDown('down') and R>= 0  then
		R = R - dt/8
	end
	if love.keyboard.isDown('G') and love.keyboard.isDown('up') and G<= 1 then
		G = G + dt/8
	end
	if love.keyboard.isDown('G') and love.keyboard.isDown('down') and G>= 0  then
		G = G - dt/8
	end
	if love.keyboard.isDown('B') and love.keyboard.isDown('up') and B<= 1 then
		B = B + dt/8
	end
	if love.keyboard.isDown('B') and love.keyboard.isDown('down') and B>= 0 then
		B = B - dt/8
	end
	if love.keyboard.isDown('A') and love.keyboard.isDown('up') and A<= 1 then
		A = A + dt/8
	end
	if love.keyboard.isDown('A') and love.keyboard.isDown('down') and A>= 0  then
		A = A - dt/8
	end
	if love.keyboard.isDown('W') and love.keyboard.isDown('up') and W<= 10 then
		W = W + dt*2.5
	end
	if love.keyboard.isDown('W') and love.keyboard.isDown('down') and W>= 2  then
		W = W - dt*2.5
	end
	if love.keyboard.isDown('q') and love.keyboard.isDown('A') then
		Snowflake = {}
	end
	if love.keyboard.isDown('s') and love.keyboard.isDown('d') then
		Stats = false
	end
	if love.keyboard.isDown('s') and love.keyboard.isDown('A') then
		Stats = true
	end
	PX,PY = X,Y
end

function love.draw()
if Stats then
	love.graphics.setColor(R,G,B)
	love.graphics.rectangle('fill',10,10,25,25)
	love.graphics.setColor(1,0,0)
	love.graphics.print(string.format("%d",R*255),10,50,0,2,2)
	love.graphics.setColor(0,1,0)
	love.graphics.print(string.format("%d",G*255),10,75,0,2,2)
	love.graphics.setColor(0,0,1)
	love.graphics.print(string.format("%d",B*255),10,100,0,2,2)
	love.graphics.setColor(1,1,1)
	love.graphics.print(string.format("%d",A*255),10,125,0,2,2)
	love.graphics.print(string.format("%d",W),10,150,0,2,2)
	
end
	love.graphics.translate(Width/2, Height/2)
	DrawStrokes(Snowflake)
	for i = 1, 6 do
		love.graphics.rotate(math.pi/3)
		DrawStrokes(Snowflake)
		love.graphics.push()
		love.graphics.scale(1, -1)
		DrawStrokes(Snowflake)
		love.graphics.pop()
	end

end
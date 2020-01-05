-- #155 Kaleidoscope Snowflake - Karim Jerbi(@apolius)

love.window.setTitle('Kaleidoscope Snowflake')
lg = love.graphics
lk = love.keyboard
function love.load()
	love.window.setFullscreen(true)
	width, height = lg.getDimensions()
	lg.setDefaultFilter('nearest')
	stats = true

	function newStroke(px,py,x,y,w,r,g,b,a)
		local stroke = {}
		stroke.px, stroke.py = px,py
		stroke.x, stroke.y = x,y
		stroke.w = w
		stroke.rgb = {r, g, b, a}
		return stroke
	end

	function drawStrokes(strokes)
		for _,stroke in pairs(strokes) do
			lg.setColor(stroke.rgb)
			lg.setLineWidth(stroke.w)
			lg.line(stroke.px, stroke.py,stroke.x, stroke.y)
		end
	end

	px,py,x,y = 0,0,0,0
	r,g,b,a = 1, 1 ,1, 1
	w = 4

	snowflake = {}
	current = {}
	
end

function love.update(dt)
	x,y = love.mouse.getPosition()
	x = x - width/2
	y = y - height/2

	if love.mouse.isDown(1) then
		current = newStroke(px,py,x,y,w,r,g,b,a)
		table.insert(snowflake, current)
	end

	-- stroke controls :
	if lk.isDown('r') and lk.isDown('up') and r<= 1 then
		r = r + dt/8
	end
	if lk.isDown('r') and lk.isDown('down') and r>= 0  then
		r = r - dt/8
	end
	if lk.isDown('g') and lk.isDown('up') and g<= 1 then
		g = g + dt/8
	end
	if lk.isDown('g') and lk.isDown('down') and g>= 0  then
		g = g - dt/8
	end
	if lk.isDown('b') and lk.isDown('up') and b<= 1 then
		b = b + dt/8
	end
	if lk.isDown('b') and lk.isDown('down') and b>= 0 then
		b = b - dt/8
	end
	if lk.isDown('a') and lk.isDown('up') and a<= 1 then
		a = a + dt/8
	end
	if lk.isDown('a') and lk.isDown('down') and a>= 0  then
		a = a - dt/8
	end
	if lk.isDown('w') and lk.isDown('up') and w<= 10 then
		w = w + dt*2.5
	end
	if lk.isDown('w') and lk.isDown('down') and w>= 2  then
		w = w - dt*2.5
	end
	if lk.isDown('q') and lk.isDown('a') then
		snowflake = {}
	end
	if lk.isDown('s') and lk.isDown('d') then
		stats = false
	end
	if lk.isDown('s') and lk.isDown('a') then
		stats = true
	end
	px,py = x,y
end

function love.draw()
if stats then
	lg.setColor(r,g,b)
	lg.rectangle('fill',10,10,25,25)
	lg.setColor(1,0,0)
	lg.print(string.format("%d",r*255),10,50,0,2,2)
	lg.setColor(0,1,0)
	lg.print(string.format("%d",g*255),10,75,0,2,2)
	lg.setColor(0,0,1)
	lg.print(string.format("%d",b*255),10,100,0,2,2)
	lg.setColor(1,1,1)
	lg.print(string.format("%d",a*255),10,125,0,2,2)
	lg.print(string.format("%d",w),10,150,0,2,2)
	
end
	lg.translate(width/2, height/2)
	drawStrokes(snowflake)
	for i = 1, 6 do
		lg.rotate(math.pi/3)
		drawStrokes(snowflake)
		lg.push()
		lg.scale(1, -1)
		drawStrokes(snowflake)
		lg.pop()
	end

end
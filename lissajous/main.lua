-- #116 Lissajous Table - Karim Jerbi(@apolius)

function love.load()
	love.window.setTitle("Lissajous Table")
	w = 80
	d = w - 8 * 2
	r = d / 2
	
	rows = math.floor(love.graphics.getHeight()/w)-1
	cols = math.floor(love.graphics.getWidth()/w)-1

	timer = 0
	angle = 0
	dAngle = math.pi / 360

    -- Create the curves
    function newCurve()
		local curve = {}
		curve.path = {0,0,0,0}
		curve.current = {}
		curve.current.x = 0
		curve.current.y = 0
		return curve
	end
    curves = {}
	for i=0, cols do
		curves[i] = {}
		for j=0, rows do
			curves[i][j] = newCurve()
		end
	end
end

function love.update()
	-- if animation if finished, halt animation
	if angle < (-2*math.pi) then
	-- pause for half the draw time so we can see the completed curves :^)
		if timer < (math.pi) then
			timer = timer + dAngle
		else
		-- reset path on all curves and restart animation 
			angle = 0
			timer = 0
			for i=0, cols-1 do
				for j=0, rows-1 do
					curves[i][j].path = {0,0,0,0}
				end
			end
		end
	else
		angle = angle - dAngle
	end
end

function love.draw()
    for i = 0, cols-1 do
		local cx = w + i * w + w / 2
		local cy = w / 2
		local x = r * math.cos(angle * (i + 1) - (math.pi/2))
		local y = r * math.sin(angle * (i + 1) - (math.pi/2))
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", cx, cy, r)
		love.graphics.circle("fill",cx+x,cy+y,5)
		love.graphics.setColor(1,1,1,0.1)
		love.graphics.line(cx+x,0,cx+x,love.graphics.getHeight())
		for j = 0,rows-1 do
			curves[i][j].current.x = x
		end
	end
	for j = 0, rows-1 do
		local cx = w / 2
		local cy = w + j * w + w / 2
		local x = r * math.cos(angle * (j + 1) - (math.pi/2))
		local y = r * math.sin(angle * (j + 1) - (math.pi/2))
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", cx, cy, r)
		love.graphics.circle("fill",cx+x,cy+y,5)
		love.graphics.setColor(1,1,1,0.2)
		love.graphics.line(0, cy+y,love.graphics.getWidth(),cy+y)
		for i = 0,cols-1 do
			curves[i][j].current.y = y
		end
	end
	for j = 0, rows-1 do
		for i = 0, cols-1 do
			local cx = curves[i][j].current.x + w + i * w + w / 2
			local cy = curves[i][j].current.y + w + j * w + w / 2
			table.insert(curves[i][j].path, cx)
			table.insert(curves[i][j].path, cy)
			love.graphics.setColor(1, 1, 1)
			love.graphics.circle("fill",cx, cy, 5)
			love.graphics.setColor(1, 1, 1, 0.4)
			love.graphics.line(curves[i][j].path)
		end
	end
end


-- #116 Lissajous Table - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle("Lissajous Table")
	W = 80
	D = W - 8 * 2
	R = D / 2
	
	Rows = math.floor(love.graphics.getHeight()/W)-1
	Cols = math.floor(love.graphics.getWidth()/W)-1

	Timer = 0
	Angle = 0
	DAngle = math.pi / 360

    -- Create the Curves
    function NewCurve()
		local curve = {}
		curve.path = {0,0,0,0}
		curve.current = {}
		curve.current.x = 0
		curve.current.y = 0
		return curve
	end
    Curves = {}
	for i=0, Cols do
		Curves[i] = {}
		for j=0, Rows do
			Curves[i][j] = NewCurve()
		end
	end
end

function love.update()
	-- if animation if finished, halt animation
	if Angle < (-2*math.pi) then
	-- pause for half the draw time so we can see the completed Curves :^)
		if Timer < (math.pi) then
			Timer = Timer + DAngle
		else
		-- reset path on all Curves and restart animation 
			Angle = 0
			Timer = 0
			for i=0, Cols-1 do
				for j=0, Rows-1 do
					Curves[i][j].path = {0,0,0,0}
				end
			end
		end
	else
		Angle = Angle - DAngle
	end
end

function love.draw()
    for i = 0, Cols-1 do
		local cx = W + i * W + W / 2
		local cy = W / 2
		local x = R * math.cos(Angle * (i + 1) - (math.pi/2))
		local y = R * math.sin(Angle * (i + 1) - (math.pi/2))
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", cx, cy, R)
		love.graphics.circle("fill",cx+x,cy+y,5)
		love.graphics.setColor(1,1,1,0.1)
		love.graphics.line(cx+x,0,cx+x,love.graphics.getHeight())
		for j = 0,Rows-1 do
			Curves[i][j].current.x = x
		end
	end
	for j = 0, Rows-1 do
		local cx = W / 2
		local cy = W + j * W + W / 2
		local x = R * math.cos(Angle * (j + 1) - (math.pi/2))
		local y = R * math.sin(Angle * (j + 1) - (math.pi/2))
		
		love.graphics.setColor(1, 1, 1)
		love.graphics.circle("line", cx, cy, R)
		love.graphics.circle("fill",cx+x,cy+y,5)
		love.graphics.setColor(1,1,1,0.2)
		love.graphics.line(0, cy+y,love.graphics.getWidth(),cy+y)
		for i = 0,Cols-1 do
			Curves[i][j].current.y = y
		end
	end
	for j = 0, Rows-1 do
		for i = 0, Cols-1 do
			local cx = Curves[i][j].current.x + W + i * W + W / 2
			local cy = Curves[i][j].current.y + W + j * W + W / 2
			table.insert(Curves[i][j].path, cx)
			table.insert(Curves[i][j].path, cy)
			love.graphics.setColor(1, 1, 1)
			love.graphics.circle("fill",cx, cy, 5)
			love.graphics.setColor(1, 1, 1, 0.4)
			love.graphics.line(Curves[i][j].path)
		end
	end
end


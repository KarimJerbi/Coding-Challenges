-- #036 Blobby - Karim Jerbi (@KarimJerbi)
-- thanks Sasha from LOVE discord

local function distance(p1, p2, s) -- steps between two control points
	s = s or 1
	return math.floor(math.sqrt((p2[1] - p1[1]) ^ 2 + (p2[2] - p1[2]) ^ 2) / s)
end

local function smooth(points, s) -- CatMull Spline - control point format {#,#}
	if #points < 3 then
		return points
	end
	local s = s or 30 -- ~ number of steps between points
	local spline = {}
	local p0, p1, p2, p3, x, y, steps
	for i = 1, #points - 1 do
		if i == 1 then -- first point (unique)
			p0, p1, p2, p3 = points[i], points[i], points[i + 1], points[i + 2]
			steps = math.floor(math.max(distance(p1, p2, s), 4)) -- # points dependent on distance (sort of)
		elseif i == #points - 1 then -- last point (unique)
			p0, p1, p2, p3 = points[#points - 2], points[#points - 1], points[#points], points[#points]
			steps = math.floor(math.max(distance(p1, p2, s), 4))
		else
			p0, p1, p2, p3 = points[i - 1], points[i], points[i + 1], points[i + 2]
			steps = math.floor(math.max(distance(p1, p2, s), 4))
		end
		for t = 0, 1, 1 / steps do
			x =0.5 * ((2 * p1[1]) + (p2[1] - p0[1]) * t + (2 * p0[1] - 5 * p1[1] + 4 * p2[1] - p3[1])
			* t * t + (3 * p1[1] - p0[1] - 3 * p2[1] + p3[1]) * t * t * t)
			y =0.5 * ((2 * p1[2]) + (p2[2] - p0[2]) * t + (2 * p0[2] - 5 * p1[2] + 4 * p2[2] - p3[2])
			* t * t + (3 * p1[2] - p0[2] - 3 * p2[2] + p3[2]) * t * t * t)
			--prevent duplicate entries
			if not (#spline > 0 and spline[#spline][1] == x and spline[#spline][2] == y) then
				spline[#spline + 1] = {math.floor(x), math.floor(y)}
			end
		end
	end
	return spline
end

-- convert table of controlePoints to a spline
function Path(controlePoints)
	local spline = smooth(controlePoints, 10)
	return spline
end

function Map(x, in_min, in_max, out_min, out_max)
	return out_min + (x - in_min)*(out_max - out_min)/(in_max - in_min)
end

function love.load()
	love.window.setTitle("Blobby")
	Vertices = {}
	Radius = 150
	Segments = 20
	
	AngleStep = (2 * math.pi) / Segments
	local angle = 0
	Y_off = 0
	local xoff = 0
	for i = 1, Segments do
		local offset = Map(love.math.noise(xoff, Y_off), 0, 1, -25, 25)
		local r = Radius + offset
		local x = r * math.cos(angle)
		local y = r * math.sin(angle)
		table.insert(Vertices, {x, y})
		xoff = xoff + 0.1
		angle = angle + AngleStep
	end
	table.insert(Vertices, Vertices[1])
	Blobby = {}
	Blobby = Path(Vertices)
end

function love.update()
local angle = 0 
local xoff = 0
	for i = 1, Segments do
		local offset = Map(love.math.noise(xoff, Y_off), 0, 1, -25, 25)
		local r = Radius + offset
		local x = r * math.cos(angle)
		local y = r * math.sin(angle)
		Vertices[i][1] = x
		Vertices[i][2] = y
		angle = angle + AngleStep
		xoff = xoff + 0.1
	end
	Y_off = Y_off +0.1
	Blobby = Path(Vertices)
	love.timer.sleep(0.1)
end

function love.draw()
	love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	love.graphics.setLineWidth(2)
	love.graphics.setLineStyle("smooth")
	local shapee = {}
	for i = 1, #Blobby - 1 do
		-- draws outline
		-- love.graphics.line(Blobby[i][1], Blobby[i][2], Blobby[i + 1][1], Blobby[i + 1][2])
		table.insert(shapee, Blobby[i][1])
		table.insert(shapee, Blobby[i][2])
	end
	table.insert(shapee, Blobby[#Blobby][1])
	table.insert(shapee, Blobby[#Blobby][2])
	love.graphics.setColor(1, 0.2, 0.4)
	love.graphics.polygon("fill", shapee)
	love.graphics.setColor(1, 1, 1)
end

-- #006 Mitosis - Karim Jerbi(@KarimJerbi)
-- cell.lua : contains code related to the cell object

random = love.math.random

function randomColor()
	r = random()
	g = random()
	b = random()
	a = 0.5
	return {r,g,b,a}
end

cells = {}

function newCell(x,y,r,c)
	cell = {}
	cell.x = x
	cell.y = y
	cell.r = r
	cell.c = c
	table.insert(cells, cell)
end

function initCells()
	timer = 0
	for i=1,5 do
		newCell(random(width),random(height),60,randomColor())
	end
end

function mitosis(cell)
	local dir = random(-1,1)
	local c1 = {}
	c1.x = cell.x+(-dir*(cell.r/2))
	c1.y = cell.y+(-dir*(cell.r/2))
	c1.r = cell.r*0.75
	c1.c = cell.c

	local c2 = {}
	c2.x = cell.x+(dir*(cell.r/2))
	c2.y = cell.y+(dir*(cell.r/2))
	c2.r = cell.r*0.75
	c2.c = cell.c

	newCell(c1.x,c1.y,c1.r,c1.c)
	newCell(c2.x,c2.y,c2.r,c2.c)
end

function clicked(o)
	local mouseX,mouseY = love.mouse.getPosition()
	local dx = o.x - mouseX
	local dy = o.y - mouseY
	local dis = math.sqrt(dx * dx + dy * dy)
	if dis < o.r then
		return true
	else
		return false 
	end
end

function updateCells(dt)
	for i, cell in ipairs(cells) do
		-- Make the cells shake
		local vel = {}
		vel.x = math.cos(random() * 2*math.pi)
		vel.y = math.sin(random() * 2*math.pi)

		cell.x = cell.x + vel.x
		cell.y = cell.y + vel.y

		-- Mitosis on mouse click
		if love.mouse.isDown(1,2) and clicked(cell) then
			timer = timer + dt
			if timer > 0.5 then 
				mitosis(cell)
				table.remove(cells,i,cell)
				timer = 0
			end
		end
	end
end

function drawCells()
	for i, cell in ipairs(cells) do
		love.graphics.setColor(cell.c)
		love.graphics.ellipse('fill', cell.x, cell.y, cell.r, cell.r)
	end
end
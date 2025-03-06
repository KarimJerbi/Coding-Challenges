-- #006 Mitosis - Karim Jerbi(@KarimJerbi)
-- cell.lua : contains code related to the cell object

function RandomColor()
	local r = love.math.random()
	local g = love.math.random()
	local b = love.math.random()
	local a = 0.5
	return {r,g,b,a}
end

Cells = {}

function NewCell(x,y,r,c)
	local cell = {}
	cell.x = x
	cell.y = y
	cell.r = r
	cell.c = c
	table.insert(Cells, cell)
end

function InitCells()
	Timer = 0
	for i=1,5 do
		NewCell(love.math.random(Width),love.math.random(Height),60,RandomColor())
	end
end

function Mitosis(cell)
	local dir = love.math.random(-1,1)
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

	NewCell(c1.x,c1.y,c1.r,c1.c)
	NewCell(c2.x,c2.y,c2.r,c2.c)
end

function Clicked(o)
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

function UpdateCells(dt)
	for i, cell in ipairs(Cells) do
		-- Make the Cells shake
		local vel = {}
		vel.x = math.cos(love.math.random() * 2*math.pi)
		vel.y = math.sin(love.math.random() * 2*math.pi)

		cell.x = cell.x + vel.x
		cell.y = cell.y + vel.y

		-- Mitosis on mouse click
		if love.mouse.isDown(1,2) and Clicked(cell) then
			Timer = Timer + dt
			if Timer > 0.5 then 
				Mitosis(cell)
				table.remove(Cells,i)
				Timer = 0
			end
		end
	end
end

function DrawCells()
	for i, cell in ipairs(Cells) do
		love.graphics.setColor(cell.c)
		love.graphics.ellipse('fill', cell.x, cell.y, cell.r, cell.r)
	end
end
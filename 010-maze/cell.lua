-- #010 Maze - Karim Jerbi(@KarimJerbi)
-- cell.lua: contains code related to the cell object

function NewCell(i,j)
	local Cell = {}
	Cell.i = i
	Cell.j = j
	Cell.walls = {true,true,true,true}
	Cell.visited = false
	return Cell
end

function Index(i,j)
	if j < 0 or i < 0 or j > Rows or i > Cols then
		return 0
	else
		return (j*(Cols)+1*j)+i+1
	end
end

Current = {}
Nxt = {}

function CheckNeighbors(Cell)
	local i,j = Cell.i,Cell.j
	local neighbors = {}
	local top    = Grid[Index(i,j-1)] 
	local right  = Grid[Index(i+1,j)] 
	local bottom = Grid[Index(i,j+1)] 
	local left   = Grid[Index(i-1,j)]
	for _,side in pairs({top,right,bottom,left}) do
		if side ~= nil and not(side.visited) then
			table.insert(neighbors,side)
		end
	end
	if #neighbors>0 then
		local r = math.floor(math.random(1,#neighbors))
		return neighbors[r]
	else
		return nil
	end
end

function Highlight(Cell)
	local x = Cell.i*W
	local y = Cell.j*W
	love.graphics.setColor(0,0,1,0.7)
	love.graphics.rectangle("fill",x,y,W,W)
end

function Draw(Cell)
	local x = Cell.i*W
	local y = Cell.j*W
	love.graphics.setColor(1,1,1)
	love.graphics.setLineWidth(4)
	if Cell.walls[1] then
		love.graphics.line(x,y,x+W,y)
	end
	if Cell.walls[2] then
		love.graphics.line(x+W,y,x+W,y+W)
	end
	if Cell.walls[3] then
		love.graphics.line(x+W,y+W,x,y+W)
	end
	if Cell.walls[4] then
		love.graphics.line(x,y+W,x,y)
	end
	if Cell.visited then
		love.graphics.setColor(1,0,1)
		love.graphics.rectangle('fill',x,y,W,W)
	end
end

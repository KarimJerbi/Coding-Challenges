-- #010 Maze - Karim Jerbi(@apolius)
-- cell.lua: contains code related to the cell object

function newCell(i,j)
	local Cell = {}
	Cell.i = i
	Cell.j = j
	Cell.walls = {true,true,true,true}
	Cell.visited = false
	return Cell
end

function index(i,j)
	if j < 0 or i < 0 or j > rows or i > cols then
		return 0
	else
		return (j*(cols)+1*j)+i+1
	end
end

current = {} 
nxt = {}

function checkNeighbors(Cell)
	local i,j = Cell.i,Cell.j
	local neighbors = {}
	local top    = grid[index(i,j-1)] 
	local right  = grid[index(i+1,j)] 
	local bottom = grid[index(i,j+1)] 
	local left   = grid[index(i-1,j)]
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

function highlight(Cell)
	local x = Cell.i*w
	local y = Cell.j*w
	lg.setColor(0,0,1,0.7)
	lg.rectangle("fill",x,y,w,w)
end

function draw(Cell)
	local x = Cell.i*w
	local y = Cell.j*w
	lg.setColor(1,1,1)
	lg.setLineWidth(4)
	if Cell.walls[1] then
		lg.line(x,y,x+w,y)
	end
	if Cell.walls[2] then
		lg.line(x+w,y,x+w,y+w)
	end
	if Cell.walls[3] then
		lg.line(x+w,y+w,x,y+w)
	end
	if Cell.walls[4] then
		lg.line(x,y+w,x,y)
	end
	if Cell.visited then
		lg.setColor(1,0,1)
		lg.rectangle('fill',x,y,w,w)
	end
end

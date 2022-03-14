-- #084 Minesweeper - Karim Jerbi @apolius

function love.load()
	love.window.setTitle('Minesweeper')
	lg = love.graphics
	lm = love.mouse
	width, height = lg.getDimensions()
	lg.setDefaultFilter('nearest')
	size = 50
	rows = math.floor(height/size)
	cols = math.floor(width/size)
	grid = {}
	mines = 25
	gamerover = false
	isFirstGuess = true

	-- creates new cell 
	function newCell(x,y,r,m)
		local cell = {}
		cell.x = x
		cell.y = y
		cell.revealed = r
		cell.isMine = m
		cell.d = 0
		return cell
	end
	
	-- inset cell in grid
	for x=1,cols do
		grid[x]={}
		for y=1,rows do
			grid[x][y] = newCell(x,y,false,false)
		end
	end
	
	-- return an item's position in a list if found or false
	function inList(table, x, y)
	local r = 0
		for i = 1, #table do
			if table[i][1] == x and table[i][2] == y  then
				r = i
			end
		end
	if r == 0 then 
		return false
	else
		return r
	end
	
	end
	
	-- put a mine in a cell
	used = {}
	function createMine(x,y)
		while inList(used,x,y) do
			x = love.math.random(1,cols)
			y = love.math.random(1,rows)
		end
		table.insert(used,{x,y})
		grid[x][y].isMine = true
	end
	for i=1, mines do
		createMine(love.math.random(1,cols),love.math.random(1,rows))
	end
	
	-- check if an item is being clicked
	function clicked(x,y)
    		local cx = math.floor(lm.getX() / size) + 1
    		local cy = math.floor(lm.getY() / size) + 1
		return  cx >= x and cx <= x and cy >= y and cy <= y and lm.isDown(1)
	end
	
	-- calculate distance to mine
	function countMines()
		for x=1,cols do
			for y=1,rows do
				grid[x][y].d = 0 --making sure the counter always starts at 0
				if grid[x][y].isMine then
      					grid[x][y].d = -1
      				else for xoff = -1, 1 do
      					for yoff = -1, 1 do
						if x+xoff<=cols and y+yoff<=rows and x+xoff>=1 and y+yoff>=1  and grid[x+xoff][y+yoff].isMine then
      							grid[x][y].d = grid[x][y].d + 1
						end
					end
				end end
			end
		end
	end
	countMines()
	
	-- clears zeros
	-- starts at x,y
	-- plugged keeps track of the old position state
	function clearZeros(x,y,plugged)
		-- making sure x and y are valid
		if x < 1 or x>cols or y<1 or y>rows then
			return nil
		-- checking the corresponding cell
		elseif grid[x][y].revealed or plugged then
			return nil
		else
			grid[x][y].revealed = true
			if grid[x][y].d >= 1 then
				plugged = true
			else
				plugged = false
			end
			for xoff = -1, 1 do
      				for yoff = -1, 1 do
					clearZeros(x+xoff,y+yoff,plugged)
				end
			end
		end
	end
end

function love.update()
	for x=1,cols do
		for y=1,rows do
			if clicked(x,y) then
				if grid[x][y].isMine == true then
					if isFirstGuess then
						grid[x][y].isMine = false
						grid[x][y].revealed = true
						createMine(love.math.random(1,cols),love.math.random(1,rows))
						table.remove(used,inList(used,x,y))
						countMines()
						if gridp[x][y].d == 0 then
							clearZeros(x,y)
						end
						isFirstGuess = false
					else
					grid[x][y].revealed = true
					gamerover = true
					end
				else
					if isFirstGuess then
						isFirstGuess = false
					end
					if grid[x][y].d == 0 then
						clearZeros(x,y,false)
					end
					grid[x][y].revealed = true
				end
			end
		end
	end
	love.timer.sleep(0.05)
end

function love.draw()
	-- draw grid lines
	lg.setColor(0.3,0.3,0.3)
	for i=1,cols do
		lg.line(size*i,0, size*i,size*rows)
	end
	for i=1,rows do
		lg.line(0,size*i, size*cols,size*i)
	end
	
	-- draw mines
	for i,mine in ipairs(used) do
		lg.setColor(0,1,1)
		lg.circle('fill',(mine[1]*size)-size/2,(mine[2]*size)-size/2,10)
	end
	
	-- draw shroud and numbers
	lg.setColor(1,1,1)
	for x=1,cols do
		for y=1,rows do
			if grid[x][y].revealed == false and gamerover == false then
				lg.rectangle('fill',(x-1)*size,(y-1)*size,size-2,size-2)
			elseif grid[x][y].d > 0 then
					lg.print(grid[x][y].d,((x-1)*size)+size/3,((y-1)*size)+size/3,0,1.5,1.5)
			end
		end
	end
end

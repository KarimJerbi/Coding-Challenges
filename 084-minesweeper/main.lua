-- #084 Minesweeper - Karim Jerbi @KarimJerbi

function love.load()
	love.window.setTitle('Minesweeper')
	Width, Height = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest')
	Size = 50
	Rows = math.floor(Height/Size)
	Cols = math.floor(Width/Size)
	Grid = {}
	Mines = 25
	Gameover = false
	IsFirstGuess = true

	-- creates new cell 
	function NewCell(x,y,r,m)
		local cell = {}
		cell.x = x
		cell.y = y
		cell.revealed = r
		cell.isMine = m
		cell.d = 0
		return cell
	end
	
	-- inset cell in Grid
	for x=1,Cols do
		Grid[x]={}
		for y=1,Rows do
			Grid[x][y] = NewCell(x,y,false,false)
		end
	end
	
	-- return an item's position in a list if found or false
	function InList(table, x, y)
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
	USED = {}
	function CreateMine(x,y)
		while InList(USED,x,y) do
			x = love.math.random(1,Cols)
			y = love.math.random(1,Rows)
		end
		table.insert(USED,{x,y})
		Grid[x][y].isMine = true
	end
	for i=1, Mines do
		CreateMine(love.math.random(1,Cols),love.math.random(1,Rows))
	end
	
	-- check if an item is being Clicked
	function Clicked(x,y)
    		local cx = math.floor(love.mouse.getX() / Size) + 1
    		local cy = math.floor(love.mouse.getY() / Size) + 1
		return  cx >= x and cx <= x and cy >= y and cy <= y and love.mouse.isDown(1)
	end
	
	-- calculate distance to mine
	function CountMines()
		for x=1,Cols do
			for y=1,Rows do
				Grid[x][y].d = 0 --making sure the counter always starts at 0
				if Grid[x][y].isMine then
      					Grid[x][y].d = -1
      				else for xoff = -1, 1 do
      					for yoff = -1, 1 do
						if x+xoff<=Cols and y+yoff<=Rows and x+xoff>=1 and y+yoff>=1  and Grid[x+xoff][y+yoff].isMine then
      							Grid[x][y].d = Grid[x][y].d + 1
						end
					end
				end end
			end
		end
	end
	CountMines()
	
	-- clears zeros
	-- starts at x,y
	-- plugged keeps track of the old position state
	function ClearZeros(x,y,plugged)
		-- making sure x and y are valid
		if x < 1 or x>Cols or y<1 or y>Rows then
			return nil
		-- checking the corresponding cell
		elseif Grid[x][y].revealed or plugged then
			return nil
		else
			Grid[x][y].revealed = true
			if Grid[x][y].d >= 1 then
				plugged = true
			else
				plugged = false
			end
			for xoff = -1, 1 do
      				for yoff = -1, 1 do
					ClearZeros(x+xoff,y+yoff,plugged)
				end
			end
		end
	end
end

function love.update()
	for x=1,Cols do
		for y=1,Rows do
			if Clicked(x,y) then
				if Grid[x][y].isMine == true then
					if IsFirstGuess then
						Grid[x][y].isMine = false
						Grid[x][y].revealed = true
						CreateMine(love.math.random(1,Cols),love.math.random(1,Rows))
						local index = InList(USED, x, y)
						if index then
							table.remove(USED, index)
						end
						CountMines()
						if Grid[x][y].d == 0 then
							ClearZeros(x,y)
						end
						IsFirstGuess = false
					else
					Grid[x][y].revealed = true
					Gameover = true
					end
				else
					if IsFirstGuess then
						IsFirstGuess = false
					end
					if Grid[x][y].d == 0 then
						ClearZeros(x,y,false)
					end
					Grid[x][y].revealed = true
				end
			end
		end
	end
	love.timer.sleep(0.05)
end

function love.draw()
	-- draw Grid lines
	love.graphics.setColor(0.3,0.3,0.3)
	for i=1,Cols do
		love.graphics.line(Size*i,0, Size*i,Size*Rows)
	end
	for i=1,Rows do
		love.graphics.line(0,Size*i, Size*Cols,Size*i)
	end
	
	-- draw Mines
	for i,mine in ipairs(USED) do
		love.graphics.setColor(0,1,1)
		love.graphics.circle('fill',(mine[1]*Size)-Size/2,(mine[2]*Size)-Size/2,10)
	end
	
	-- draw shroud and numbers
	love.graphics.setColor(1,1,1)
	for x=1,Cols do
		for y=1,Rows do
			if Grid[x][y].revealed == false and Gameover == false then
				love.graphics.rectangle('fill',(x-1)*Size,(y-1)*Size,Size-2,Size-2)
			elseif Grid[x][y].d > 0 then
					love.graphics.print(Grid[x][y].d,((x-1)*Size)+Size/3,((y-1)*Size)+Size/3,0,1.5,1.5)
			end
		end
	end
end

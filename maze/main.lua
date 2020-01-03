-- #010 Maze Generator - Karim Jerbi(@apolius)

function love.load()
	love.window.setTitle("Maze Generator")
	love.window.setFullscreen(true)
	lg = love.graphics
	width, height = lg.getDimensions()
	w = 20
	cols = math.floor(width/w)-1
	rows = math.floor(height/w)-1
	
	require "cell"
	grid = {}
	stack = {}
	for i = 0, rows do 
		for j = 0, cols do 
			table.insert(grid,newCell(j,i))
		end
	end
 	current = grid[1]
	function rmWalls(a,b)
		local x = a.i - b.i
		if x == 1 then
			a.walls[4] = false
			b.walls[2] = false
		elseif x == -1 then
			a.walls[2] = false
			b.walls[4] = false
		end
		local y = a.j - b.j
		if y == 1 then
			a.walls[1] = false
			b.walls[3] = false
		elseif y == -1 then
			a.walls[3] = false
			b.walls[1] = false
		end
	end
 	--timer = 0 -- timer to slow it down ;)
end

function love.update(dt)
--timer = timer + dt
--if timer > 0.1 then
	current.visited = true
	nxt = checkNeighbors(current)
	if nxt ~= nil then
		nxt.visited = true
		table.insert(stack,current)
		rmWalls(current,nxt)
		current = nxt
	elseif #stack > 1 then
		table.remove(stack,#stack)
		current = stack[#stack]
	end 
	if love.keyboard.isDown("r") then
		love.event.quit("restart")
	end
	--timer = 0
--end
end

function love.draw()
	for i = 1,#grid do
		draw(grid[i])
	end
	highlight(current)
end

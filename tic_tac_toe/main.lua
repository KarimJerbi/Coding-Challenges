-- #149 Tic Tac Toe - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Tic Tac Toe')
width = love.graphics.getWidth()
height = love.graphics.getHeight()
love.graphics.setDefaultFilter("nearest")

g = love.graphics

players = {"X","O"}
gamestates = {"", "X WON","O WON", "DRAW"}

function init()
	currentPlayer = "X"
	gameover = 0 -- *notover(0) *X wins(1) *O wins(2) *draw(3)
	state = {false,0,0}
	board = {
			{"","",""},
			{"","",""},
			{"","",""}
			}

	boardAV = {
			{true,true,true},
			{true,true,true},
			{true,true,true}
			}
end
init()

function XO(x,y,xo)
	local XOx =  240 + x*150
	local XOy =  75 + y*150
	g.setColor(30/255,220/255,150/255)
	g.print(xo,XOx,XOy,0,8)
end

x,y = 0,0
function mouseScan(x,y,Fx,Fy)
	local inX = x > (200 + Fx*150) and x < (350 + Fx*150)
	local inY = y > (50 + Fy*150) and y < (200 + Fy*150)
	if inX and inY and boardAV[Fy+1][Fx+1] then
		if currentPlayer == "O" then
			board[Fy+1][Fx+1] = currentPlayer
			currentPlayer = "X"
			boardAV[Fy+1][Fx+1] = false
		else
			board[Fy+1][Fx+1] = currentPlayer
			currentPlayer = "O"
			boardAV[Fy+1][Fx+1] = false
		end
	end
end

function E3(a,b,c)
	if a==b and b==c and c~="" then
		return true
	else
		return false
	end
end

function checkState()
	for k=1,3 do
		if E3(board[k][1],board[k][2],board[k][3]) then
			return {true,k-1,1,board[k][2]}
		end
		if E3(board[1][k],board[2][k],board[3][k]) then
			return {true,k-1,2,board[2][k]}
		end
	end
	if E3(board[1][1],board[2][2],board[3][3]) then
		return {true,1,3,board[2][2]}
	end
	if E3(board[3][1], board[2][2], board[1][3]) then
		return {true,1,4,board[2][2]}
	end
	return {false,0,0,""}
end

function draw()
	for i=1,3 do
		for j=1,3 do 
			if boardAV[j][i] == true then
				return false
			end
		end
	end
	return true
end

function strike(state)
	g.setLineWidth(10)
	g.setColor(0,0,0)
	if state[3] == 1 then
		g.line(200,125+150*state[2],650,125+150*state[2])
	end
	if state[3] == 2 then
		g.line(275+150*state[2],50,275+150*state[2],500)
	end
	if state[3] == 3 then
		g.line(200,50,650,500)
	end
	if state[3] == 4 then
		g.line(650,50,200,500)
	end
end

end

function love.update(dt)
	if gameover == 0 and love.mouse.isDown(1) then
		for i=0, 2 do
			for j=0, 2 do
				x,y = love.mouse.getPosition() 
				mouseScan(x,y,i,j)
			end
		end
		state = checkState()
		if state[1] and state[4] == "X" then
			gameover = 1
		elseif state[1] and state[4] == "O" then
			gameover = 2
		end
		if draw() then 
			gameover = 3
		end
	end
	if love.keyboard.isDown('r') then
		init()
	end
end

function love.draw()
	g.setLineWidth(4)
	g.setBackgroundColor(1,1,1)
	g.setColor(30/255,220/255,150/255)
	g.ellipse('fill',60,60,30,30)
	g.setColor(0,0,0)
	g.print(currentPlayer,52.5,50,0,2)

	g.line(350,50,350,500)
	g.line(500,50,500,500)

	g.line(200,200,650,200)
	g.line(200,350,650,350)
	for i=0, 2 do
		for j=0, 2 do 
			XO(i,j,board[j+1][i+1])
		end
	end
	if gameover%3 ~= 0 then
		strike(state)
	end
	g.print(gamestates[gameover+1],10,500)
	if gameover~= 0 then
		g.print("press r to restart /"..state[3],10,550)
	end
end
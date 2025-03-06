-- #149 Tic Tac Toe - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('Tic Tac Toe')
Width = love.graphics.getWidth()
Height = love.graphics.getHeight()
love.graphics.setDefaultFilter("nearest")

Players = {"X","O"}
Gamestates = {"", "X WON","O WON", "DRAW"}

function INIT()
	CurrentPlayer = "X"
	Gameover = 0 -- *notover(0) *X wins(1) *O wins(2) *draw(3)
	State = {false,0,0}
	Board = {
			{"","",""},
			{"","",""},
			{"","",""}
			}

	BoardAV = {
			{true,true,true},
			{true,true,true},
			{true,true,true}
			}
end
INIT()

function XO(X,Y,xo)
	local XOx =  240 + X*150
	local XOy =  75 + Y*150
	love.graphics.setColor(30/255,220/255,150/255)
	love.graphics.print(xo,XOx,XOy,0,8)
end

X, Y = 0,0
function MouseScan(X,Y,Fx,Fy)
	local inX = X > (200 + Fx*150) and X < (350 + Fx*150)
	local inY = Y > (50 + Fy*150) and Y < (200 + Fy*150)
	if inX and inY and BoardAV[Fy+1][Fx+1] then
		if CurrentPlayer == "O" then
			Board[Fy+1][Fx+1] = CurrentPlayer
			CurrentPlayer = "X"
			BoardAV[Fy+1][Fx+1] = false
		else
			Board[Fy+1][Fx+1] = CurrentPlayer
			CurrentPlayer = "O"
			BoardAV[Fy+1][Fx+1] = false
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

function CheckState()
	for k=1,3 do
		if E3(Board[k][1],Board[k][2],Board[k][3]) then
			return {true,k-1,1,Board[k][2]}
		end
		if E3(Board[1][k],Board[2][k],Board[3][k]) then
			return {true,k-1,2,Board[2][k]}
		end
	end
	if E3(Board[1][1],Board[2][2],Board[3][3]) then
		return {true,1,3,Board[2][2]}
	end
	if E3(Board[3][1], Board[2][2], Board[1][3]) then
		return {true,1,4,Board[2][2]}
	end
	return {false,0,0,""}
end

function Draw()
	for i=1,3 do
		for j=1,3 do 
			if BoardAV[j][i] == true then
				return false
			end
		end
	end
	return true
end

function Strike(State)
	love.graphics.setLineWidth(10)
	love.graphics.setColor(0,0,0)
	if State[3] == 1 then
		love.graphics.line(200,125+150*State[2],650,125+150*State[2])
	end
	if State[3] == 2 then
		love.graphics.line(275+150*State[2],50,275+150*State[2],500)
	end
	if State[3] == 3 then
		love.graphics.line(200,50,650,500)
	end
	if State[3] == 4 then
		love.graphics.line(650,50,200,500)
	end
end

end

function love.update(dt)
	if Gameover == 0 and love.mouse.isDown(1) then
		for i=0, 2 do
			for j=0, 2 do
				X,Y = love.mouse.getPosition() 
				MouseScan(X,Y,i,j)
			end
		end
		State = CheckState()
		if State[1] and State[4] == "X" then
			Gameover = 1
		elseif State[1] and State[4] == "O" then
			Gameover = 2
		end
		if Draw() then 
			Gameover = 3
		end
	end
	if love.keyboard.isDown('r') then
		INIT()
	end
end

function love.draw()
	love.graphics.setLineWidth(4)
	love.graphics.setBackgroundColor(1,1,1)
	love.graphics.setColor(30/255,220/255,150/255)
	love.graphics.ellipse('fill',60,60,30,30)
	love.graphics.setColor(0,0,0)
	love.graphics.print(CurrentPlayer,52.5,50,0,2)

	love.graphics.line(350,50,350,500)
	love.graphics.line(500,50,500,500)

	love.graphics.line(200,200,650,200)
	love.graphics.line(200,350,650,350)
	for i=0, 2 do
		for j=0, 2 do 
			XO(i,j,Board[j+1][i+1])
		end
	end
	if Gameover%3 ~= 0 then
		Strike(State)
	end
	love.graphics.print(Gamestates[Gameover+1],10,500)
	if Gameover~= 0 then
		love.graphics.print("press r to restart",10,550)
	end
end
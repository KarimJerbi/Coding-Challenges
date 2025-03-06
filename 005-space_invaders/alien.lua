-- #005 Space Invaders - Karim Jerbi(@KarimJerbi)
-- alien.lua : contains code related to the alien object
AlienSize = Window.width/16
RowSize = 8
Rows = {{}, {}, {}}
function NewAlien(x,y,row)
	local alien = {}
	alien.x = x
	alien.y = y
	alien.shape = love.math.random(3)
	alien.rgb = RandomColor()
	table.insert(row, 1, alien)	
end

function InitAliens()
Rows= {{}, {}, {}}
for row = 1, #Rows do
	for i = 1, RowSize do
		local x = ((i-1)*AlienSize)+(i*AlienSize)
		local y = (row*AlienSize)-AlienSize/2
		NewAlien(x,y,Rows[row])
	end
end
end

M = true
Dis = 0
function MoveRow(row,dir)
	if M then
	if dir == 1 then
		for d,alien in ipairs(row) do
			if alien.x+AlienSize+0.55 > Window.width then
				M = false
			else
				alien.x = alien.x + 0.55
			end
		end
	elseif dir == 2 or dir == 0 then
		for d,alien in ipairs(row) do
			if alien.y+0.55 > Window.height or Dis >= AlienSize*10 then
				M = false
			else
				alien.y = alien.y + 0.55
				Dis = Dis + 0.55
			end
		end
	
	elseif dir == 3 then
		for d,alien in ipairs(row) do
			if alien.x-0.55 < 0 then
				M = false
			else
				alien.x = alien.x - 0.55
			end
		end
	end
	end
end

Atimer = 0
function AnimateAliens(row)
	for i, alien in ipairs(row) do
		if Atimer > 1 and Atimer<2 then
			if alien.shape == 1 then
				alien.shape = 5
			elseif alien.shape == 2 then 
				alien.shape = 6
			elseif alien.shape == 3 then
				alien.shape = 7
			end
		end
		if Atimer > 2 then
			if alien.shape == 5 then
				alien.shape = 1
			elseif alien.shape == 6 then 
				alien.shape = 2
			elseif alien.shape == 7 then
				alien.shape = 3
			end
		end
	end

end

Acts = {true,false,false,false,false,false,false,false}
P = 1
FT = 1
function UpdateAliens(dt)
	Atimer = Atimer + dt
	for i=1,#Rows do 
		AnimateAliens(Rows[i])
	end
	if Atimer > 2 then
		Atimer = 0
	end

	-- move the aliens
	if Acts[P] == true then
		for l=1, #Rows do
			MoveRow(Rows[l], P - math.floor(P/4)*4)
		end
	end
	if M == false and Acts[P] == true then
		Dis = 0
		M = true
		Acts[P] = false
		Acts[P+1] = true
		P = P + 1
	end
end

function DrawAliens()
	for j=1, #Rows do
		for i, alien in ipairs(Rows[j]) do
			love.graphics.setColor(alien.rgb)
			love.graphics.draw(Spacesheet,Shapes[alien.shape],alien.x,alien.y,0,AlienSize/8,AlienSize/8)
		end
	end
end

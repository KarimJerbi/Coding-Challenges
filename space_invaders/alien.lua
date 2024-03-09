-- #005 Space Invaders - Karim Jerbi(@KarimJerbi)
-- alien.lua : contains code related to the alien object
alienSize = window.width/16
rowSize = 8

row1 , row2, row3 = {}, {}, {}
rows = {row1, row2, row3}

function newAlien(x,y,row)
	alien = {}
	alien.x = x
	alien.y = y
	alien.shape = love.math.random(3)
	alien.rgb = randomColor()
	table.insert(row, 1, alien)	
end

function initAliens()
row1, row2, row3 = {}, {}, {}
rows= {row1, row2, row3}
for row = 1, #rows do
	for i = 1, rowSize do
		local x = ((i-1)*alienSize)+(i*alienSize)
		local y = (row*alienSize)-alienSize/2
		newAlien(x,y,rows[row])
	end
end
end

m = true
dis = 0
function moveRow(row,dir)
	if m then
	if dir == 1 then
		for d,alien in ipairs(row) do
			if alien.x+alienSize+0.55 > window.width then
				m = false
			else
				alien.x = alien.x + 0.55
			end
		end
	elseif dir == 2 or dir == 0 then
		for d,alien in ipairs(row) do
			if alien.y+0.55 > window.height or dis >= alienSize*10 then
				m = false
			else
				alien.y = alien.y + 0.55
				dis = dis + 0.55
			end
		end
	
	elseif dir == 3 then
		for d,alien in ipairs(row) do
			if alien.x-0.55 < 0 then
				m = false
			else
				alien.x = alien.x - 0.55
			end
		end
	end
	end
end

Atimer = 0
function animateAliens(row)
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

acts = {true,false,false,false,false,false,false,false}
p = 1
ft = 1
function updateAliens(dt)
	Atimer = Atimer + dt
	for i=1,#rows do 
		animateAliens(rows[i])
	end
	if Atimer > 2 then
		Atimer = 0
	end

	-- move the aliens
	if acts[p] == true then
		for l=1, #rows do
			moveRow(rows[l], p - math.floor(p/4)*4)
		end
	end
	if m == false and acts[p] == true then
		dis = 0
		m = true
		acts[p] = false
		acts[p+1] = true
		p = p + 1
	end
end

function drawAliens()
	for j=1, #rows do
		for i, alien in ipairs(rows[j]) do
			love.graphics.setColor(alien.rgb)
			love.graphics.draw(spacesheet,shapes[alien.shape],alien.x,alien.y,0,alienSize/8,alienSize/8)
		end
	end
end

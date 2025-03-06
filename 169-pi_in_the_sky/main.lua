-- #169 Pi in the Sky - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle('Pi in the Sky')
	Height = love.graphics.getHeight()
	Width = love.graphics.getWidth()
	Pi = '31415926535897932384626433832795'
	Gamerover = false
    Timer = 1
    PieSize = 24
    Pies = {}
    Cols = Width/PieSize
    Plate = {}
    -- 50 is half the Plate's Width
    Plate.x = Width/2 - 50
    -- 40 is 2 times the Plate's Height
    Plate.y = Height - 40
    Num = 1
    function NewPie()
    	local Pie ={}
    	Pie.x = love.math.random(1,Cols)*PieSize
		Pie.y = 0
		Pie.Num = tostring(love.math.random(0,9))
		table.insert(Pies, Pie)
    end
	function PiSlices(Pie)
		love.graphics.setColor(1,1,1)
		love.graphics.circle('line',Pie.x,Pie.y,PieSize)
		love.graphics.push()
  		local a = (math.pi*2)/9
  		local d = PieSize
  		love.graphics.translate(Pie.x, Pie.y)
    	for i = 1,Pie.Num do
    		  love.graphics.setColor(230/255, 200/255, 1)
    	      love.graphics.arc('fill','pie',0, 0, d, i*a, (i+1)*a)
    	      love.graphics.setColor(1,1,1)
    	      love.graphics.arc('line','pie',0, 0, d, i*a, (i+1)*a)
    	end
    	love.graphics.pop()	
	end
end

function love.update(dt)
if not(Gamerover)then
Timer = Timer + dt
if Timer >= 0.5 then 
	Timer = 0
	NewPie()
end
for i,Pie in ipairs(Pies) do
	if Pie.y > Height then 
		table.remove(Pies,i)
	elseif Pie.x  >= Plate.x and Pie.x <= Plate.x+100 and Pie.y+PieSize/2 > Plate.y then
		table.remove(Pies,i)
		if string.sub(Pi,Num,Num) ~= Pie.Num then
			Gamerover = true
		else
		Num = Num + 1
		end
	end
	Pie.y = Pie.y + 1
end
if love.keyboard.isDown('left') then
	Plate.x = Plate.x - 5
elseif love.keyboard.isDown('right') then
	Plate.x = Plate.x + 5
end
end
end

function love.draw()
if Gamerover then 
	love.graphics.setBackgroundColor(1,0,0)
	love.graphics.print('Gamerover',Width/2,Height/2)
else
	love.graphics.setColor(1,1,1)
	love.graphics.rectangle('fill',Plate.x,Plate.y,100,20)
	for _,Pie in pairs(Pies) do
		PiSlices(Pie)
	end
	love.graphics.setColor(0,0,0)
	love.graphics.rectangle('fill',0,0,Width,50)
	for i=string.len(Pi),1,-1 do
		if i < Num+3 then
			love.graphics.setColor(0,0,1)
			if i == Num then 
				love.graphics.setColor(0,1,0)
			elseif i < Num then
				love.graphics.setColor(1,1,1)
			end
			
			love.graphics.circle('line',i*30+5*i,30,15)
			love.graphics.print(string.sub(Pi,i,i),i*27.5+5*i,22.5)
		end
	end
end
end


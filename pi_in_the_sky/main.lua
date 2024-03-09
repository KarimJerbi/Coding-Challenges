-- #0169 Pi in the Sky - Karim Jerbi(@KarimJerbi)
function love.load()
	love.window.setTitle('Pi in the Sky')
	lg = love.graphics
	lk = love.keyboard
	height = lg.getHeight()
	width = lg.getWidth()
	pi = '31415926535897932384626433832795'
	gameover = false
    timer = 1
    pieSize = 24
    pies = {}
    cols = width/pieSize
    plate = {}
    -- 50 is half the plate's width
    plate.x = width/2 - 50
    -- 40 is 2 times the plate's height
    plate.y = height - 40
    num = 1
    function newPie()
    	local pie ={}
    	pie.x = love.math.random(1,cols)*pieSize
		pie.y = 0
		pie.num = tostring(love.math.random(0,9))
		table.insert(pies, pie)
    end
	function piSlices(pie)
		lg.setColor(1,1,1)
		lg.circle('line',pie.x,pie.y,pieSize)
		lg.push()
  		local a = (math.pi*2)/9
  		local d = pieSize
  		lg.translate(pie.x, pie.y)
    	for i = 1,pie.num do
    		  lg.setColor(230/255, 200/255, 1)
    	      lg.arc('fill','pie',0, 0, d, i*a, (i+1)*a)
    	      lg.setColor(1,1,1)
    	      lg.arc('line','pie',0, 0, d, i*a, (i+1)*a)
    	end
    	lg.pop()	
	end
end

function love.update(dt)
if not(gameover)then
timer = timer + dt
if timer >= 0.5 then 
	timer = 0
	newPie()
end
for i,pie in ipairs(pies) do
	if pie.y > height then 
		table.remove(pies,i)
	elseif pie.x  >= plate.x and pie.x <= plate.x+100 and pie.y+pieSize/2 > plate.y then
		table.remove(pies,i)
		if string.sub(pi,num,num) ~= pie.num then
			gameover = true
		else
		num = num + 1
		end
	end
	pie.y = pie.y + 1
end
if lk.isDown('left') then
	plate.x = plate.x - 5
elseif lk.isDown('right') then
	plate.x = plate.x + 5
end
end
end

function love.draw()
if gameover then 
	lg.setBackgroundColor(1,0,0)
	lg.print('GAMEOVER',width/2,height/2)
else
	lg.setColor(1,1,1)
	lg.rectangle('fill',plate.x,plate.y,100,20)
	for _,pie in pairs(pies) do
		piSlices(pie)
	end
	lg.setColor(0,0,0)
	lg.rectangle('fill',0,0,width,50)
	for i=string.len(pi),1,-1 do
		if i < num+3 then
			lg.setColor(0,0,1)
			if i == num then 
				lg.setColor(0,1,0)
			elseif i < num then
				lg.setColor(1,1,1)
			end
			
			lg.circle('line',i*30+5*i,30,15)
			lg.print(string.sub(pi,i,i),i*27.5+5*i,22.5)
		end
	end
end
end

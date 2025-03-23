-- #095 Pi:Monte Carlo - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('Pi : Monte Carlo')
R = 256 -- window size * 0.5

Points = {}

function NewPoint()
	local point = {}
	point.x = math.random(-R,R)
	point.y = math.random(-R,R)
	
	if (point.x)^2 + (point.y)^2 <= R^2 then 
		point.pos = 0
	else
		point.pos = 1
	end
	
	return point
end

P = NewPoint()
C = 0.0
Total = 0
Pie = 0
end

function love.update()
for i=1,100 do
	P = NewPoint()
	if P.pos == 0 then 
		C = C + 1
	end
	table.insert(Points, P)
end
Total = Total+ 100
Pie = 4*(C/Total)
love.window.setTitle('Pi : Monte Carlo : '..Pie)
end

function love.draw()
	love.graphics.translate(R,R)
	for _,point in ipairs(Points) do
		if point.pos == 0 then
			love.graphics.setColor(1,1,1)
		else
			love.graphics.setColor(0,0.2,0.5)
		end
		love.graphics.Points(point.x,point.y)
	end
end

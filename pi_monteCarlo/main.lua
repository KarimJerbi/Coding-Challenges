-- #095 Pi:Monte Carlo - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('Pi : Monte Carlo')
lg = love.graphics
r = 256 -- window size * 0.5

points = {}

function newpoint()
	local point = {}
	point.x = math.random(-r,r)
	point.y = math.random(-r,r)
	
	if (point.x)^2 + (point.y)^2 <= r^2 then 
		point.pos = 0
	else
		point.pos = 1
	end
	
	return point
end

p = newpoint()
c = 0.0
total = 0
pie = 0
end

function love.update()
for i=1,100 do
	p = newpoint()
	if p.pos == 0 then 
		c = c + 1
	end
	table.insert(points, p)
end
total = total+ 100
pie = 4*(c/total)
love.window.setTitle('Pi : Monte Carlo : '..pie)
end

function love.draw()
	lg.translate(r,r)
	for _,point in ipairs(points) do
		if point.pos == 0 then
			lg.setColor(1,1,1)
		else
			lg.setColor(0,0.2,0.5)
		end
		lg.points(point.x,point.y)
	end
end

-- #030 Phyllotaxis - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Phyllotaxis')
function love.load()
	g = love.graphics
	n = 0
	c = 3
	i = 1
	start = 0
	points = {}

	function newPoint()
		local angle = i * 137.5;
		local r = c * math.sqrt(i)
		point = {}
		point.x = r * math.cos(angle)*2
		point.y = r * math.sin(angle)*2
		table.insert(points, point)
	end
end

function love.update()
	newPoint()
	start = start + 5
	n = n + 5
	i = i +1
end

function love.draw()
	love.graphics.translate(g.getWidth() / 2, g.getHeight() / 2)
	love.graphics.rotate(math.rad(n * 0.3))
	for _,point in ipairs(points) do
		love.graphics.ellipse('fill', point.x, point.y, 4, 4)
	end
end
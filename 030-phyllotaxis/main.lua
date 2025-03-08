-- #030 Phyllotaxis - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Phyllotaxis')
function love.load()
	N = 0
	C = 3
	I = 1
	Start = 0
	Points = {}

	function NewPoint()
		local angle = I * 137.5;
		local r = C * math.sqrt(I)
		local point = {}
		point.x = r * math.cos(angle)*2
		point.y = r * math.sin(angle)*2
		table.insert(Points, point)
	end
end

function love.update()
	NewPoint()
	Start = Start + 5
	N = N + 5
	I = I +1
end

function love.draw()
	love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
	love.graphics.rotate(math.rad(N * 0.3))
	for _,point in ipairs(Points) do
		love.graphics.ellipse('fill', point.x, point.y, 4, 4)
	end
end
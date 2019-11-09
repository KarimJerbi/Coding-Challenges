-- #014 Fractal Tree - Karim Jerbi(@apolius)

function love.load()
	love.window.setTitle('Fractal Tree')
	angle = math.pi/4
	branchRatio = 0.67
	g = love.graphics

	function branch(len)
		g.line(0,0,0,-len)
		g.translate(0, -len)
		if len>4 then
			g.push()
			g.rotate(angle)
			branch(len * branchRatio)
			g.pop()
			g.push()
			g.rotate(-angle)
			branch(len * branchRatio)
			g.pop()
		end
	end

end
function love.update(dt)
	if love.keyboard.isDown('up') then
		angle = angle + dt
	elseif love.keyboard.isDown('down') then
		angle = angle - dt
	end
end

function love.draw()
	g.translate(g.getWidth()/2, g.getHeight())
	branch(200)
end

-- #014 Fractal Tree - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle('Fractal Tree')
	Angle = math.pi/4
	BranchRatio = 0.67

	function Branch(len)
		love.graphics.line(0,0,0,-len)
		love.graphics.translate(0, -len)
		if len>4 then
			love.graphics.push()
			love.graphics.rotate(Angle)
			Branch(len * BranchRatio)
			love.graphics.pop()
			love.graphics.push()
			love.graphics.rotate(-Angle)
			Branch(len * BranchRatio)
			love.graphics.pop()
		end
	end

end
function love.update(dt)
	if love.keyboard.isDown('up') then
		Angle = Angle + dt
	elseif love.keyboard.isDown('down') then
		Angle = Angle - dt
	end
end

function love.draw()
	love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight())
	Branch(200)
end

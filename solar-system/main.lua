-- #007 Solar System 2D - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Solar System')
width = love.graphics.getWidth()
height = love.graphics.getHeight()

require('orbs')

sun = newOrb(50,0,1,0)

end

function love.update(dt)
	orbit(sun)
	--love.timer.sleep(0.1)
end

function love.draw()
	love.graphics.translate(width/2, height/2)
	drawOrb(sun)
end

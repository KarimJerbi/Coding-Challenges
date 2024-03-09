-- #006 Mitosis - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Mitosis')

function love.load()
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	require('cell')

	initCells()
end

function love.update(dt)
	updateCells(dt)
	if love.keyboard.isDown('r') then
		cells = {}
		initCells()
	end
end

function love.draw()
	drawCells()
end
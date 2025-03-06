-- #006 Mitosis - Karim Jerbi(@KarimJerbi)

love.window.setTitle('Mitosis')

function love.load()
	Height = love.graphics.getHeight()
	Width = love.graphics.getWidth()
	require('cell')

	InitCells()
end

function love.update(dt)
	UpdateCells(dt)
	if love.keyboard.isDown('r') then
		Cells = {}
		InitCells()
	end
end

function love.draw()
	DrawCells()
end
-- #182 Apollonian Gasket - Karim Jerbi(@KarimJerbi)
function love.load()
	love.window.setTitle("Apollonian Gasket")
	love.window.setMode(800, 800)
	local Gasket = require("gasket")

	COLOR1 = {112/255, 50/255, 126/255, 1}
	COLOR2 = {45/255, 197/255, 244/255, 1}

	Gaskets = {}
	local seed = love.math.random(100000)

	-- Create initial gasket
	table.insert(Gaskets, Gasket.new(400, 400, 400, {0, 0, 0, 1}, seed))
	-- Recurse
	for n = 1, 2 do
		for i = #Gaskets, 1, -1 do
			local nextG = Gaskets[i]:recurse()
			if nextG then
				for _, g in ipairs(nextG) do
					table.insert(Gaskets, g)
				end
			end
		end
	end
end
function love.draw()
	love.graphics.setBackgroundColor(LerpColor(COLOR1,{0, 0, 0, 1}, 0.5))
	for _, g in ipairs(Gaskets) do
		g:show()
	end
end
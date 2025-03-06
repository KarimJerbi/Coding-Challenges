-- #183 Mathematical Marbling - Karim Jerbi(@KarimJerbi)

-- Array to store all ink drops
local drops = {}
-- Track the start of mouse drag
local start

-- Initialize the game
function love.load()
	love.window.setTitle("Mathematical Marbling")
	require "ink"

	-- Add an ink drop to the canvas
	function AddInk(x, y, r)
		local drop = Drop:new(x, y, r)	
		-- Interact new drop with all existing drops in reverse order
		for i = #drops, 1, -1 do
			drops[i]:marble(drop)
		end

		table.insert(drops, drop)
	end

	-- Add 20 ink drops at the center of the canvas
	for i = 1, 20 do
		AddInk(300, love.graphics.getHeight() / 2, 50)
	end

	-- Add 50 ink drops at random positions on the canvas
	for i = 1, 50 do
		local x = love.math.random(love.graphics.getWidth())
		local y = love.math.random(love.graphics.getHeight())
		local r = love.math.random(10, 50)
		AddInk(x, y, r)
	end
end

-- Record the starting point
function love.mousepressed(x, y, button)
	if button == 1 then
	start = {x = x, y = y}
	end
end

-- Apply tine effects to ink drops
function TineLine(direction, x, y, z, c)
	for _, drop in ipairs(drops) do
		drop:tine(direction, x, y, z, c)
	end
	end

-- Handle mouse drag to simulate ink spreading
function love.mousereleased(x, y, button)
	if button == 1 then
		local endPoint = {x = x, y = y}
		local dx = endPoint.x - start.x
		local dy = endPoint.y - start.y
		local distance = math.sqrt(dx * dx + dy * dy)
		local direction = {x = dx / distance, y = dy / distance}
		TineLine(direction, x, y, 2, 16)
		start = nil
	end
end

function love.draw()
	for _, drop in ipairs(drops) do
		drop:draw()
	end
end

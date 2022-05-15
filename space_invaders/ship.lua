-- #005 Space Invaders - Karim Jerbi(@apolius)
-- ship.lua : contains code related to the ship object

function initShip()
	ship = {}
	ship.size = 75
	ship.x = window.width/2
	ship.y = window.height-ship.size
end

function moveShip()
	if love.keyboard.isDown('left') and (ship.x > 0) then
		ship.x = ship.x - 10
	elseif love.keyboard.isDown('right') and (ship.x <= window.width-ship.size) then
		ship.x = ship.x + 10
	end
end

function dead()
r = false
	for _,row in ipairs(rows) do
		for _,alien in pairs(row) do
		if alien.y+alienSize >= ship.y then
			r = true
		end
		end
	end
return r
end

function drawShip()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(spacesheet,shapes[4],ship.x,ship.y,0,ship.size/9,ship.size/9)
end
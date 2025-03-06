-- #005 Space Invaders - Karim Jerbi(@KarimJerbi)
-- ship.lua : contains code related to the ship object

function InitShip()
	Ship = {}
	Ship.size = 75
	Ship.x = Window.width/2
	Ship.y = Window.height-Ship.size
end

function MoveShip()
	if love.keyboard.isDown('left') and (Ship.x > 0) then
		Ship.x = Ship.x - 10
	elseif love.keyboard.isDown('right') and (Ship.x <= Window.width-Ship.size) then
		Ship.x = Ship.x + 10
	end
end

function Dead()
local r = false
	for _,row in ipairs(Rows) do
		for _,alien in pairs(row) do
		if alien.y + AlienSize >= Ship.y then
			r = true
		end
		end
	end
return r
end

function DrawShip()
	love.graphics.setColor(1, 1, 1)
	love.graphics.draw(Spacesheet,Shapes[4],Ship.x,Ship.y,0,Ship.size/9,Ship.size/9)
end
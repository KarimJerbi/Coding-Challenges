-- #005 Space Invaders - Karim Jerbi(@apolius)
-- bullet.lua : contains code related to the bullet object

bullets = {} -- ONLY PLAYER BULLETS

function newBullet()
	bullet = {}
	bullet.x = ship.x+(ship.size/2)
	bullet.y = ship.y
	table.insert(bullets, bullet)
end

timer = 0
function addBullets(dt)
	timer = timer + dt
	if timer > 0.7 and love.keyboard.isDown('space')then
		newBullet()
		timer = 0
	end
end

function updateBullets(dt)
	addBullets(dt)
	for i, bullet in ipairs(bullets) do
		bullet.y = bullet.y - 5
		if bullet.y < 0 then
			table.remove(bullets, i)
		end
	end
end

function drawBullets()
	for i, bullet in ipairs(bullets) do
		love.graphics.setColor(0.21, 0.81, 0.34)
		love.graphics.rectangle('fill', bullet.x, bullet.y, 5, 50)
	end
end
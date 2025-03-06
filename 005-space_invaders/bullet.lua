-- #005 Space Invaders - Karim Jerbi(@KarimJerbi)
-- bullet.lua : contains code related to the bullet object

Bullets = {} -- ONLY PLAYER Bullets

function NewBullet()
	local bullet = {}
	bullet.x = Ship.x+(Ship.size/2)
	bullet.y = Ship.y
	table.insert(Bullets, bullet)
end

Timer = 0
function AddBullets(dt)
	Timer = Timer + dt
	if Timer > 0.7 and love.keyboard.isDown('space')then
		NewBullet()
		Timer = 0
	end
end

function UpdateBullets(dt)
	AddBullets(dt)
	for i, bullet in ipairs(Bullets) do
		bullet.y = bullet.y - 5
		if bullet.y < 0 then
			table.remove(Bullets, i)
		end
	end
end

function DrawBullets()
	for i, bullet in ipairs(Bullets) do
		love.graphics.setColor(0.21, 0.81, 0.34)
		love.graphics.rectangle('fill', bullet.x, bullet.y, 5, 50)
	end
end
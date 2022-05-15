-- #005 Space Invaders - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Space Invaders')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.speed = 0.1
Gtimer = 0 

love.graphics.setDefaultFilter("nearest")
spacesheet = love.graphics.newImage("sprites.png")
shapes = {}
for i=0,1 do
	for d=0,3 do
		shape = love.graphics.newQuad((8*i)+i, (8*d)+d, 8, 8, spacesheet:getDimensions())
		table.insert(shapes,shape)
	end
end

function randomColor()
	r = love.math.random()
	g = love.math.random()
	b = love.math.random()
	return {r,g,b}
end

require("ship")
require("alien")
require("bullet")

target = {-100,-100,{1,1,1}}

initShip()
initAliens()
gameover = 0
end

function love.update(dt)
if #rows[1]+#rows[2]+#rows[3] == 0 then
	gameover = 1
	msg = 'YOU WIN'
elseif dead() then
	gameover = 1
	msg = 'YOU LOST'

else
Gtimer = Gtimer + dt
moveShip()
updateAliens(dt)
updateBullets(dt)

-- This Part kills aliens and creates the particules effect
-- It Also removes Bullets that hit the target 
for j, bullet in ipairs(bullets) do
	for v = 1, #rows do
	for i, alien in ipairs(rows[v]) do
		x,y = false
		if not((bullet.y < alien.y)
		   or (bullet.y > alien.y+alienSize)) then
			y = true
		end
		if not((bullet.x+5 < alien.x)
		   or (bullet.x > alien.x+alienSize)) then
			x = true
		end
		if x and y then
			target = {alien.x,alien.y,alien.rgb}
			table.remove(rows[v], i)
			table.remove(bullets,j)
			break
		end
	end
end
end
if Gtimer > 0.6 then
	target = {-100,-100,{1,1,1}}
	Gtimer = 0
end

end
if gameover == 1 and love.keyboard.isDown('r') then
	initShip()
	initAliens()
	gameover = 0
end
end

function love.draw()
if gameover == 0 then
	drawShip()
	drawAliens()
	love.graphics.setColor(target[3])
	love.graphics.draw(spacesheet,shapes[8],target[1],target[2],0,alienSize/8,alienSize/8)
	drawBullets()
else
	love.graphics.setColor(1,1,1)
	love.graphics.print(msg,(window.width/2)-100, (window.height/4),0,4)
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle('line', (window.width/2)-150, (window.height/2)-75, 300, 150)
	love.graphics.print('G A M E O V E R',(window.width/2)-145, (window.height/2)-75,0,3)
	love.graphics.print('R to restart',(window.width/2)-60, (window.height/2)+25,0,2)
end
end
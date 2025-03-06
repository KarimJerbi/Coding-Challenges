-- #005 Space Invaders - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('Space Invaders')
Window = {}
Window.width = love.graphics.getWidth()
Window.height = love.graphics.getHeight()
Window.speed = 0.1
Gtimer = 0

love.graphics.setDefaultFilter("nearest")
Spacesheet = love.graphics.newImage("sprites.png")
Shapes = {}
for i=0,1 do
	for d=0,3 do
		local shape = love.graphics.newQuad((8*i)+i, (8*d)+d, 8, 8, Spacesheet:getDimensions())
		table.insert(Shapes,shape)
	end
end

function RandomColor()
	local r = love.math.random()
	local g = love.math.random()
	local b = love.math.random()
	return {r,g,b}
end

require("ship")
require("alien")
require("bullet")

Target = {-100,-100,{1,1,1}}

InitShip()
InitAliens()
Gameover = 0
end

function love.update(dt)
	if #Rows[1]+#Rows[2]+#Rows[3] == 0 then
		Gameover = 1
		MSG = 'YOU WIN'
	elseif Dead() then
		Gameover = 1
		MSG = 'YOU LOST'

	else
		Gtimer = Gtimer + dt
		MoveShip()
		UpdateAliens(dt)
		UpdateBullets(dt)

	-- This Part kills aliens and creates the particules effect
	-- It Also removes Bullets that hit the target 
	for j, bullet in ipairs(Bullets) do
		for v = 1, #Rows do
		for i, alien in ipairs(Rows[v]) do
			local x,y = false, false
			if not((bullet.y < alien.y)
			or (bullet.y > alien.y+AlienSize)) then
				y = true
			end
			if not((bullet.x+5 < alien.x)
			or (bullet.x > alien.x+AlienSize)) then
				x = true
			end
			if x and y then
				Target = {alien.x,alien.y,alien.rgb}
				table.remove(Rows[v], i)
				table.remove(Bullets,j)
				break
			end
		end
	end
	end
	if Gtimer > 0.6 then
		Target = {-100,-100,{1,1,1}}
		Gtimer = 0
	end

	end
	if Gameover == 1 and love.keyboard.isDown('r') then
		InitShip()
		InitAliens()
		Gameover = 0
	end
end

function love.draw()
	if Gameover == 0 then
		DrawShip()
		DrawAliens()
		love.graphics.setColor(Target[3])
		love.graphics.draw(Spacesheet,Shapes[8],Target[1],Target[2],0,AlienSize/8,AlienSize/8)
		DrawBullets()
	else
		love.graphics.setColor(1,1,1)
		love.graphics.print(MSG,(Window.width/2)-100, (Window.height/4),0,4)
		love.graphics.setColor(1,0,0)
		love.graphics.rectangle('line', (Window.width/2)-150, (Window.height/2)-75, 300, 150)
		love.graphics.print('G A M E O V E R',(Window.width/2)-145, (Window.height/2)-75,0,3)
		love.graphics.print('R to restart',(Window.width/2)-60, (Window.height/2)+25,0,2)
	end
end
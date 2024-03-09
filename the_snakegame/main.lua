-- #003 The Snake Game - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('The Snake Game')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.time = 0
gameover = 0
scl = 20

ft = 1
score = 0

snake = {}
snake.x = 0
snake.y = 0
snake.xspeed = 20
snake.yspeed = 0
snake.size = 1

tail = {}
function addtoTail()
	unit = {}
	unit.x = snake.x
	unit.y = snake.y
	unit.xspeed = snake.xspeed
	unit.yspeed = snake.yspeed
	table.insert(tail, snake.size,unit)
end
function updateTail() -- Thank you for the help, love2d forums user Xugro ^-^
	if #tail > 0 then
	for i = 1, #tail do
			if i == #tail then
				tail[i].x = snake.x
				tail[i].y = snake.y
			else
				tail[i].x = tail[i+1].x
				tail[i].y = tail[i+1].y

			end
		end
	end
end

rgb = {0.1,0.5,0.1}
function randomColor()
	r = love.math.random()
	g = love.math.random()
	b = love.math.random()
	return {r,g,b}
end

food = {}
function newFood() -- food shouldn't spawn on top of snake
	rgb = randomColor()
	local cols = math.floor(window.width/scl)
	local rows = math.floor(window.height/scl)
	food.x = love.math.random(cols-1)*scl
	food.y = love.math.random(rows-1)*scl
end
newFood()

function eaten(b1,b2)
	local one = not((b1.x+scl/2 < b2.x) or (b1.x > b2.x+scl/2))
	local two = not((b1.y+scl/2 < b2.y) or (b1.y > b2.y+scl/2))
	return one and two
end

function alive()
	for i, v in ipairs(tail) do
	if i ~= #tail then
		if snake.x == v.x and snake.y == v.y then
			gameover = 1
		end
	end
	end
end

end

function love.update(dt)
if gameover == 0 then
	window.time = window.time + dt
	-- drive system
	if love.keyboard.isDown('up') and snake.yspeed~=20 then
		snake.xspeed = 0
		snake.yspeed = -20
	elseif love.keyboard.isDown('down') and snake.yspeed~=-20 then
		snake.xspeed = 0
		snake.yspeed = 20
	elseif love.keyboard.isDown('right') and snake.xspeed~=-20 then
		snake.xspeed = 20
		snake.yspeed = 0
	elseif love.keyboard.isDown('left') and snake.xspeed~=20 then
		snake.xspeed = -20
		snake.yspeed = 0
	end
	if eaten(snake,food) then
		score = score +1
		if ft == 1 then addtoTail() ft = ft + 1 end
		snake.size = snake.size + 1
		addtoTail()
		newFood()
	end
	if window.time>0.1 then
	-- constrain & move the snake
		if (snake.x + scl < window.width) and (snake.xspeed == 20) then
			snake.x = snake.x + snake.xspeed
		end
		if (snake.x > 0) and (snake.xspeed == -20) then
			snake.x = snake.x + snake.xspeed
		end
		if (snake.y + scl < window.height) and (snake.yspeed == 20)then
			snake.y = snake.y + snake.yspeed
		end
		if (snake.y > 0) and (snake.yspeed == -20) then
			snake.y = snake.y + snake.yspeed
		end
		alive()      --check if snake eat it's tail
		updateTail()
		window.time = 0
	end

else
	if love.keyboard.isDown('r')then
		snake.x, snake.y = 0,0
		snake.xspeed, snake.yspeed = 20,0
		local count = #tail
		for i=0, count do tail[i]=nil end
		tail = {}
		snake.size = 1
		score = 0
		gameover = 0
		ft = 1
	end
end
end

function love.draw()
love.graphics.setColor(0, 1, 0.2)
for i,unit in pairs(tail) do
love.graphics.rectangle('fill', unit.x, unit.y,scl,scl)
end
love.graphics.setColor(0, 1, 0.2)
love.graphics.rectangle('fill', snake.x, snake.y, scl, scl)
love.graphics.setColor(1, 0, 0)
love.graphics.rectangle('fill', snake.x+15, snake.y, 5, 5)   -- Make the eyes move according to snake head movement !
love.graphics.rectangle('fill', snake.x+15, snake.y+15, 5, 5)
love.graphics.setColor(rgb)
love.graphics.rectangle('fill', food.x, food.y, scl, scl)
love.graphics.setColor(1,1,1)
love.graphics.print(score)
if gameover == 1 then
	love.graphics.setColor(1,0,0)
	love.graphics.rectangle('line', (window.width/2)-150, (window.height/2)-75, 300, 150)
	love.graphics.print('G A M E O V E R',(window.width/2)-145, (window.height/2)-75,0,3)
	love.graphics.print('R to restart',(window.width/2)-60, (window.height/2)+25,0,2)
end
end
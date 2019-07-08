-- #139 Pi:Collisions - Karim Jerbi(@apuleius)

require 'slam'

function love.load()
love.window.setTitle('Pi:Collisions')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()

click = love.audio.newSource('click.wav', 'static')

count = 0
digits = 4

block1 = {}
block1.size = 20
block1.x = 100
block1.v = 0
block1.m = 1

block2 = {}
block2.size = 100
block2.x = 300
block2.v = -10 ^ (-digits)
block2.m = 100 ^ (digits-1)

function collide(b1,b2)
	return not((b1.x+b1.size < b2.x) or (b1.x > b2.x+b2.size))
end

function bounce(b1,b2)
	sumM = b1.m + b2.m
	return ((b1.m-b2.m)/sumM * b1.v) + ((2*b2.m/sumM) * b2.v)
end

function hitwall(b)
	if b.x <=0 then
		b.v = -b.v
		love.audio.play(click)
		count = count+1
	end
end

end

function love.update(dt)
for i = 1, 500 do
block1.x = block1.x + block1.v
if collide(block1,block2) then
	local v1 = bounce(block1,block2)
	local v2 = bounce(block2,block1)
	block1.v = v1
	block2.v = v2
	love.audio.play(click)
	count = count+1
end
hitwall(block1)
hitwall(block2)
block2.x = block2.x + block2.v
end

end

function love.draw()
love.graphics.setColor(0.3, 0.1, 0.6)
love.graphics.rectangle('fill', block1.x, window.height/2-block1.size, block1.size, block1.size)
love.graphics.setColor(0.1, 0.2, 0.4)
love.graphics.rectangle('fill', block2.x, window.height/2-block2.size, block2.size, block2.size)
love.graphics.setColor(1,1,1)
love.graphics.print(count, 10, 20)
end
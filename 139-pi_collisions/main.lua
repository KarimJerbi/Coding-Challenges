-- #139 Pi:Collisions - Karim Jerbi(@KarimJerbi)

require 'slam'

function love.load()
love.window.setTitle('Pi:Collisions')
Window = {}
Window.width = love.graphics.getWidth()
Window.height = love.graphics.getHeight()

Click = love.audio.newSource('Click.ogg', 'static')

Count = 0
Digits = 3

Block1 = {}
Block1.size = 20
Block1.x = 100
Block1.v = 0
Block1.m = 1

Block2 = {}
Block2.size = 100
Block2.x = 300
Block2.v = -10 ^ (-Digits)
Block2.m = 100 ^ (Digits-1)

function Collide(b1,b2)
	return not((b1.x+b1.size < b2.x) or (b1.x > b2.x+b2.size))
end

function Bounce(b1,b2)
	local sumM = b1.m + b2.m
	return ((b1.m-b2.m)/sumM * b1.v) + ((2*b2.m/sumM) * b2.v)
end

function HitWall(b)
	if b.x <=0 then
		b.v = -b.v
		local instance = Click:play()  
		Count = Count+1
	end
end

end

function love.update(dt)
for i = 1, 500 do
Block1.x = Block1.x + Block1.v
if Collide(Block1,Block2) then
	local v1 = Bounce(Block1,Block2)
	local v2 = Bounce(Block2,Block1)
	Block1.v = v1
	Block2.v = v2
	love.audio.play(Click)
	Count = Count+1
end
HitWall(Block1)
HitWall(Block2)
Block2.x = Block2.x + Block2.v
end

end

function love.draw()
love.graphics.setColor(0.3, 0.1, 0.6)
love.graphics.rectangle('fill', Block1.x, Window.height/2-Block1.size, Block1.size, Block1.size)
love.graphics.setColor(0.1, 0.2, 0.4)
love.graphics.rectangle('fill', Block2.x, Window.height/2-Block2.size, Block2.size, Block2.size)
love.graphics.setColor(1,1,1)
love.graphics.print(Count, 10, 20)
end
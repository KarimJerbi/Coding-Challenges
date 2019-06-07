-- #131 Bouncing DVD - Karim Jerbi(@apolius) 06-2019

function love.load()
love.window.setTitle('Bouncing DVD')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.xSpeed = 2
window.ySpeed = 2

dvd = love.graphics.newImage("gfx/dvd.png")
x = (window.width/2)+dvd:getWidth()
y = (window.height/2)+dvd:getHeight()

function randomColor()
	r = love.math.random(100/255,1)
	g = love.math.random(100/255,1)
	b = love.math.random(100/255,1)
	love.graphics.setColor(r, g, b)
end

end

function love.update(dt)
x = x + window.xSpeed
y = y + window.ySpeed

if (x + dvd:getWidth() >= window.width) then
	window.xSpeed = -window.xSpeed
	x = window.width - dvd:getWidth()
	randomColor()
elseif (x <= 0) then
	window.xSpeed = -window.xSpeed
	x = 0
	randomColor();
end

if (y + dvd:getHeight() >= window.height) then
	window.ySpeed = -window.ySpeed
	y = window.height - dvd:getHeight()
	randomColor()
elseif (y <= 0) then
	window.ySpeed = -window.ySpeed
	y = 0
	randomColor()
end

end

function love.draw()
	love.graphics.draw(dvd, x, y)

end

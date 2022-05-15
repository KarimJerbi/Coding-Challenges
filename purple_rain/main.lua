-- #004 Purple Rain - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Purple Rain')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
rain = {}
function newdrop()
	drop = {}
	drop.x = love.math.random(window.width)
	drop.y = love.math.random(-50,0)
	drop.z = love.math.random(1,5)
	drop.h = love.math.random(5,25)
	drop.w = 1.25 * drop.z
	drop.speed = drop.z
	table.insert(rain,drop)
end

end

function love.update()
for i,v in pairs(rain) do
	v.y = v.y+v.speed
	if v.y >= window.width then
		table.remove(rain, i)
	end
end
while table.maxn(rain) < 400 do -- number of stars
	newdrop()
end
end

function love.draw()
love.graphics.setBackgroundColor(230/255, 200/255, 1)
for _,v in pairs(rain) do
	love.graphics.setColor(138/255, 43/255, 226/255)
	love.graphics.setLineWidth(v.w)
	love.graphics.line(v.x, v.y, v.x, v.y+v.h)
end

end

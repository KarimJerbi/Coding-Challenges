-- #001 starfield - Karim Jerbi(@apolius) 06-2019

function love.load()
love.window.setTitle('Starfield')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
window.speed = 0.1
stars = {}
function newstar()
	star = {}
	star.x = love.math.random(-window.width/2,window.width/2)
	star.y = love.math.random(-window.height/2,window.height/2)
	star.zx = window.width
	star.zy = window.height
	--star.px = star.x -- I dont like how this looks
	--star.py = star.y -- this along other commented lines 
	                   -- creates star lines
	star.r = 1         --star initial size
	table.insert(stars,star)
end

end

function love.update(dt)
-- TODO add touch support
gas = love.keyboard.isDown('space')
if gas and window.speed < 5 then -- speed limit
	window.speed = window.speed + 0.04
elseif window.speed > 0.1 then
	window.speed = window.speed - 0.08
end

for i,v in pairs(stars) do
	--star.px = star.x --lines
	--star.py = star.y --lines
	v.zx = v.zx - window.speed
	v.zy = v.zy - window.speed
	v.x = v.x/v.zx * window.width
	v.y = v.y/v.zy * window.height
	v.r = v.r + 0.01

	if (math.abs(v.x) > window.width/2) or
	   (math.abs(v.y) > window.height/2) or
	   (v.x == 0 and v.y == 0) then
		table.remove(stars, i)
	end
end
while table.maxn(stars) < 75 do -- number of stars
	newstar()
end
end

function love.draw()
love.graphics.translate(window.width/2,window.height/2)
for _,v in pairs(stars) do
	love.graphics.setColor(1,1,1)
	love.graphics.circle('fill', v.x, v.y, v.r)
	--love.graphics.line(v.px, v.py, v.x, v.y) --lines
end
-- TODO add a planet/star/object destination at x,y = 0,0
end

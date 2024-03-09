-- #088 snowfall - Karim Jerbi(@KarimJerbi) 06-2019
snowsheet = love.graphics.newImage("flakes32.png")

function love.load()
love.window.setTitle('Snowfall')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
snow = {}
function newflake()
	flake = {}
	flake.x = love.math.random(window.width)
	flake.y = love.math.random(-50,0)
	flake.z = love.math.random(9,12)
	flake.size = flake.z/10
	flake.orientation = math.deg(0)
	flake.shape = love.math.random(1,256)
	flake.speed = flake.z-7
	table.insert(snow,flake)
end

flakes32 = {}
for i=0,16 do
	for d=0,16 do
		oneflake = love.graphics.newQuad(32*i, 32*d, 32, 32, snowsheet:getDimensions())
		table.insert(flakes32,oneflake)
	end
end

d = 0
end

function love.update(dt)
for i,v in pairs(snow) do
	v.y = v.y+v.speed
	if v.y >= window.width then
		table.remove(snow, i)
	end
	d = d +dt/200
	v.orientation = d
end
while table.maxn(snow) < 200 do -- number of flakes
	newflake()
end
end

function love.draw()
for _,v in pairs(snow) do
	love.graphics.setColor(1,1,1)
	love.graphics.draw(snowsheet,
					   flakes32[v.shape],
					   v.x,v.y,
					   v.orientation,
					   v.size,v.size,
					   16,16
					   )
end

end
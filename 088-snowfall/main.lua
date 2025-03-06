-- #088 snowfall - Karim Jerbi(@KarimJerbi) 06-2019
Snowsheet = love.graphics.newImage("flakes32.png")

function love.load()
love.window.setTitle('Snowfall')
Window = {}
Window.width = love.graphics.getWidth()
Window.height = love.graphics.getHeight()
Snow = {}
function NewFlake()
	local flake = {}
	flake.x = love.math.random(Window.width)
	flake.y = love.math.random(-50,0)
	flake.z = love.math.random(9,12)
	flake.size = flake.z/10
	flake.orientation = math.deg(0)
	flake.shape = love.math.random(1,256)
	flake.speed = flake.z-7
	table.insert(Snow,flake)
end

Flakes32 = {}
for i=0,16 do
	for d=0,16 do
		local oneflake = love.graphics.newQuad(32*i, 32*d, 32, 32, Snowsheet:getDimensions())
		table.insert(Flakes32,oneflake)
	end
end

D = 0
end

function love.update(dt)
for i,v in pairs(Snow) do
	v.y = v.y+v.speed
	if v.y >= Window.width then
		table.remove(Snow, i)
	end
	D = D +dt/200
	v.orientation = D
end
while table.maxn(Snow) < 200 do -- number of flakes
	NewFlake()
end
end

function love.draw()
for _,v in pairs(Snow) do
	love.graphics.setColor(1,1,1)
	love.graphics.draw(Snowsheet,
					   Flakes32[v.shape],
					   v.x,v.y,
					   v.orientation,
					   v.size,v.size,
					   16,16
					   )
end

end
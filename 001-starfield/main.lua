-- #001 starfield - Karim Jerbi(@KarimJerbi) 06-2019

function love.load()
	love.window.setTitle('Starfield')
	Window = {}
	Window.width = love.graphics.getWidth()
	Window.height = love.graphics.getHeight()
	Window.speed = 0.1
	Stars = {}
	function Newstar()
		local star = {}
		star.x = love.math.random(-Window.width/2,Window.width/2)
		star.y = love.math.random(-Window.height/2,Window.height/2)
		star.zx = Window.width
		star.zy = Window.height
		--star.px = star.x -- I dont like how this looks,
		--star.py = star.y -- This along other commented lines 
						   -- creates star lines.
		star.r = 1         -- star initial size
		table.insert(Stars,star)
	end

end

function love.update(dt)
	Gas = love.keyboard.isDown('space')
	if Gas and Window.speed < 5 then -- speed limit
		Window.speed = Window.speed + 0.04
	elseif Window.speed > 0.1 then
		Window.speed = Window.speed - 0.08
	end

	for i,v in pairs(Stars) do
		--star.px = star.x --lines
		--star.py = star.y --lines
		v.zx = v.zx - Window.speed
		v.zy = v.zy - Window.speed
		v.x = v.x/v.zx * Window.width
		v.y = v.y/v.zy * Window.height
		v.r = v.r + 0.01

		if (math.abs(v.x) > Window.width/2) or
		(math.abs(v.y) > Window.height/2) or
		(v.x == 0 and v.y == 0) then
			table.remove(Stars, i)
		end
	end
	while table.maxn(Stars) < 75 do -- number of stars
		Newstar()
	end
end

function love.draw()
	love.graphics.translate(Window.width/2,Window.height/2)
	for _,v in pairs(Stars) do
		love.graphics.setColor(1,1,1)
		love.graphics.circle('fill', v.x, v.y, v.r)
		--love.graphics.line(v.px, v.py, v.x, v.y) --lines
	end
end

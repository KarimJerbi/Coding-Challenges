-- #117 Seven-Segment Display - Karim Jerbi (@KarimJerbi) 06-2019

function love.load()
	love.window.setTitle('Seven Segment Display')
	Height = love.graphics.getHeight()

	Input = 0

	-- n : 0:off 1:on order:abcdefg (see wikipedia)
	-- example N = "1110111" display A
	-- x,y: where to draw
	-- s: Size
	function NewDisplay(n,x,y,s)
		local display = {}
		display.A = {}
		display.A.x = x + s
		display.A.y = y
		display.B = {}
		display.B.x = x + (4*s)
		display.B.y = y + s
		display.C = {}
		display.C.x = display.B.x 
		display.C.y = y + (5*s)
		display.D = {}
		display.D.x = display.A.x
		display.D.y = y + (8*s)
		display.e = {}
		display.e.x  = x
		display.e.y = display.C.y
		display.f = {}
		display.f.x = x
		display.f.y = display.B.y
		display.g = {}
		display.g.x = display.A.x
		display.g.y = y + (4*s)
		-- A
		love.graphics.setColor(1, 0, 0, string.sub(n, 1, 1))
		love.graphics.rectangle('fill',display.A.x,display.A.y,s*3, s,s/2,s/2)
		-- B
		love.graphics.setColor(1, 0, 0, string.sub(n, 2, 2))
		love.graphics.rectangle('fill',display.B.x,display.B.y,s, 3*s, s,s/2,s/2)
		-- C
		love.graphics.setColor(1, 0, 0, string.sub(n, 3, 3))
		love.graphics.rectangle('fill',display.C.x,display.C.y,s, 3*s, s,s/2,s/2)
		-- D
		love.graphics.setColor(1, 0, 0, string.sub(n, 4, 4))
		love.graphics.rectangle('fill',display.D.x,display.D.y,s*3, s, s,s/2,s/2)
		-- E
		love.graphics.setColor(1, 0, 0, string.sub(n, 5, 5))
		love.graphics.rectangle('fill',display.e.x,display.e.y,s, 3*s, s,s/2,s/2)
		-- F
		love.graphics.setColor(1, 0, 0, string.sub(n, 6, 6))
		love.graphics.rectangle('fill',display.f.x,display.f.y,s, 3*s, s,s/2,s/2)
		-- G
		love.graphics.setColor(1, 0, 0, string.sub(n, 7, 7))
		love.graphics.rectangle('fill',display.g.x,display.g.y,s*3, s, s,s/2,s/2)

	end
	function Encoder(n)
		local r = "0000000"
		if n == 0 then
			r = "1111110"
		elseif n == 1 then
			r = "0110000"
		elseif n == 2 then
			r = "1101101"
		elseif n == 3 then
			r = "1111001"
		elseif n == 4 then
			r = "0110011"
		elseif n == 5 then
			r = "1011011"
		elseif n == 6 then
			r = "1011111"
		elseif n == 7 then
			r = "1110000"
		elseif n == 8 then
			r = "1111111"
		elseif n == 9 then
			r = "1111011"
		end
		return r
	end
end

function love.update(dt)
	if Input < 9999 then
		Input = Input + dt
	elseif Input >= 9999 then
		Input = 0
	end

	A = math.floor(Input % 10)
	B = math.floor((Input % 100 - A) /10)
	C = math.floor((Input % 1000 - B*10 - A)/100)
	D = math.floor((Input % 10000 -C*100 - B*10 - A)/1000)
end

function love.draw()
	NewDisplay(Encoder(A),650,(Height/2)-100,25)
	NewDisplay(Encoder(B),450,(Height/2)-100,25)
	NewDisplay(Encoder(C),250,(Height/2)-100,25)
	NewDisplay(Encoder(D),50,(Height/2)-100,25)
end

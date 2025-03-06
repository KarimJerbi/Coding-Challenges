-- #120 Bit Shifting - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle("Bit Shifting")
	Width, Height = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest')
	Bits = '11111111'
	R = 255

	function Convert(Bits)
		local R = 0
		for i=1,8 do
			if string.reverse(Bits):sub(i,i) == '1' then
				R = R + 2^(i-1)
			end
		end
		return R
	end

	X,Y = love.mouse.getPosition()

	function Clicked(X,Y,cx,cy)
		-- check if the mouse has Clicked a bit(cx,cy)
		return (X - cx)^2 + (Y - cy)^2 < 25^2 and love.mouse.isDown(1)
	end

	function Flip(Bits,X)
		local bit = Bits:sub(X,X)
		if bit == '1' then bit = '0' else bit = '1' end
		-- generate a new byte with the new bit
		-- based on the position of the new bit
		-- there are 3 positions: 
		-- start / end \ inside
		if X == 1 then
			return bit .. Bits:sub(2,-1)
		elseif X == Bits:len() then
			return Bits:sub(1,-2)..bit
		else
			return Bits:sub(1,X-1)..bit..Bits:sub(X+1,-1)
		end
	end
	
	function RShift(Bits) -- shift to the right
		local R = ''
		for i=1,Bits:len()-1 do
			R = R .. Bits:sub(i,i)
		end
		return '0' .. R
	end

	function LShift(Bits) -- shift to the left
		local R = ''
		for i=Bits:len(),2,-1 do
			R = Bits:sub(i,i) .. R
		end
		return R .. '0'
	end
end

function love.update(dt)
	X,Y = love.mouse.getPosition()
	for i=1,8 do
		if Clicked(X,Y,20+(i*55),100)then
			Bits = Flip(Bits,i)
			R = Convert(Bits)
			love.timer.sleep(0.12)
		end
	end
	if Clicked(X,Y,250,300) then
		Bits = LShift(Bits)
		R = Convert(Bits)
		love.timer.sleep(0.12)
	end
	if Clicked(X,Y,350,300) then
		Bits = RShift(Bits)
		R = Convert(Bits)
		love.timer.sleep(0.12)
	end
end

function love.draw()
	love.graphics.clear(0.6,0.5,0.75)
	for i=1,8 do
		if Bits:sub(i,i) == '1' then
			love.graphics.setColor(1,1,1)
			love.graphics.ellipse('fill',20+(i*55),100,25,25)
		end
		love.graphics.ellipse('line',20+(i*55),100,25,25)
	end
	love.graphics.setColor(1,1,1)
	love.graphics.ellipse('line',250,300,25,25)
	love.graphics.print('<<',230,275,0,2,3)
	love.graphics.ellipse('line',350,300,25,25)
	love.graphics.print('>>',330,275,0,2,3)
	love.graphics.print(R,Width/4,Height/4,0,8,8)
end

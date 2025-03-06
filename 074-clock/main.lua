-- #074 Clock - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle("Clock")
	Width, Height = love.graphics.getDimensions()
end

function love.update()
	Time = os.date("*t")
	SecA = math.pi/30 * Time.sec
	MinA = math.pi/30 * Time.min
	HourA = math.pi/6 * Time.hour
end

function love.draw()
	love.graphics.translate(Width/2,Height/2)
	love.graphics.rotate(-math.pi/2)
	love.graphics.setLineWidth(8)
	love.graphics.setColor(1,100/255,150/255)
	love.graphics.arc("line","open",0,0,225,0,SecA)
	love.graphics.push()
	love.graphics.rotate(SecA-math.pi/2)
	love.graphics.line(0,0,0,200)
	love.graphics.pop()
	love.graphics.setColor(150/255,100/255,1)
	love.graphics.arc("line","open",0,0,250,0,MinA)	
	love.graphics.push()
	love.graphics.rotate(MinA-math.pi/2)
	love.graphics.line(0,0,0,175)
	love.graphics.pop()
	love.graphics.setColor(150/255,1,100/255)
	love.graphics.arc("line","open",0,0,275,0,HourA)
	love.graphics.push()
	love.graphics.rotate(HourA-math.pi/2)
	love.graphics.line(0,0,0,150)
	love.graphics.pop()
end

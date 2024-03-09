-- #074 Clock - Karim Jerbi(@KarimJerbi)

function love.load()
	love.window.setTitle("Clock")
	width, height = love.graphics.getDimensions()
	lg = love.graphics
	pi = math.pi
end

function love.update()
	time = os.date("*t")
	secA = pi/30 * time.sec
	minA = pi/30 * time.min
	hourA = pi/6 * time.hour
end

function love.draw()
	lg.translate(width/2,height/2)
	lg.rotate(-pi/2)
	lg.setLineWidth(8)
	lg.setColor(1,100/255,150/255)
	lg.arc("line","open",0,0,225,0,secA)
	lg.push()
	lg.rotate(secA-pi/2)
	lg.line(0,0,0,200)
	lg.pop()
	lg.setColor(150/255,100/255,1)
	lg.arc("line","open",0,0,250,0,minA)	
	lg.push()
	lg.rotate(minA-pi/2)
	lg.line(0,0,0,175)
	lg.pop()
	lg.setColor(150/255,1,100/255)
	lg.arc("line","open",0,0,275,0,hourA)
	lg.push()
	lg.rotate(hourA-pi/2)
	lg.line(0,0,0,150)
	lg.pop()
end

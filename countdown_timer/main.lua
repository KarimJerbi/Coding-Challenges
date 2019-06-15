-- #066 Countdown Timer - Karim Jerbi (@apolius)
require("display")

function love.load()
love.window.setTitle('Countdown Timer')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()
position = (window.width-60*3)/60

input = 80 -- edit this to modify the timing
seconds,minutes,hours,s,ss,m,mm,h,hh = 0
end

function love.update(dt)
	input= input -dt
	seconds = math.floor(math.mod(input,60))
	s = seconds % 10
	ss = (seconds - s) / 10
	minutes= math.floor((math.mod(input,3600)-seconds)/60)
	m = minutes % 10
	mm = (minutes - m) / 10
	hours = (math.floor(input)-math.floor(input % 3600))/3600
	h = hours % 10
	hh = (hours - h) / 10

end

function love.draw()
	newdisplay(encoder(s),650,(window.height/2)-100,20)
	newdisplay(encoder(ss),525,(window.height/2)-100,20)
	newdisplay(encoder(m),395,(window.height/2)-100,20)
	newdisplay(encoder(mm),270,(window.height/2)-100,20)
	newdisplay(encoder(h),135,(window.height/2)-100,20)
	newdisplay(encoder(hh),10,(window.height/2)-100,20)
end

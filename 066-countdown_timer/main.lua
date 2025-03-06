-- #066 Countdown Timer - Karim Jerbi (@KarimJerbi)
require("display")

function love.load()
love.window.setTitle('Countdown Timer')
Window = {}
Window.width = love.graphics.getWidth()
Window.height = love.graphics.getHeight()
Input = 80 -- edit this to modify the timing
Seconds, Minutes, Hours, S, SS, M, MM, H, HH = 0, 0, 0, 0, 0, 0, 0, 0, 0
end

function love.update(dt)
	if math.floor(Input) ~= 0 then
		Input= Input -dt
		Seconds = math.floor(Input % 60)
		S = Seconds % 10
		SS = (Seconds - S) / 10
		Minutes= math.floor(((Input % 3600) - Seconds)/60)
		M = Minutes % 10
		MM = (Minutes - M) / 10
		Hours = (math.floor(Input)-math.floor(Input % 3600))/3600
		H = Hours % 10
		HH = (Hours - H) / 10
	end
end

function love.draw()
	NewDisplay(Encoder(S),650,(Window.height/2)-100,20)
	NewDisplay(Encoder(SS),525,(Window.height/2)-100,20)
	NewDisplay(Encoder(M),395,(Window.height/2)-100,20)
	NewDisplay(Encoder(MM),270,(Window.height/2)-100,20)
	NewDisplay(Encoder(H),135,(Window.height/2)-100,20)
	NewDisplay(Encoder(HH),10,(Window.height/2)-100,20)
end

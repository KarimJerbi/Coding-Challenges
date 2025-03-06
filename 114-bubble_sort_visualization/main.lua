-- #114 Bubble Sort Visualization - Karim Jerbi(@KarimJerbi)

function love.load()
love.window.setTitle('Bubble Sort Visualization')
Window = {}
Window.width = love.graphics.getWidth()
Window.height = love.graphics.getHeight()

Count = 15
Stroke = Window.width/Count

Values = {}
for I=1, Count do
	table.insert(Values, I, love.math.random(Window.height)) 
end
I, J = 1,0
Timer = 0
Timer2 = 0

end

function love.update(dt)

Timer = Timer + dt*15
if (Timer > 0.5) and (I <= Count-1) then
	Timer2 = Timer2 + dt*15
	if Timer2 > 0.5 and (J<Count-I)then
		J = J + 1
		if Values[J]>Values[J+1] then
			local temp = Values[J]
			Values[J] = Values[J+1]
			Values[J+1] = temp
		end
		Timer2 = 0
	end
	if J == Count-I then
		I = I + 1
		J = 0
	end
	Timer = 0
end

end

function love.draw()

love.graphics.setLineWidth(Stroke)
love.graphics.translate(Stroke/2, 0)
for I,v in ipairs(Values) do
	love.graphics.setColor(1, 1, 1)
	love.graphics.line((I-1)*Stroke, Window.height, (I-1)*Stroke,Window.height-v)
	love.graphics.setColor(1, 0.5,1)
end
love.graphics.print(J)
love.graphics.print(I, 0, 20)
end
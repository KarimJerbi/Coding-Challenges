-- #114 Bubble Sort Visualization - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Bubble Sort Visualization')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()

count = 15
stroke = window.width/count

values = {}
for i=1, count do
	table.insert(values, i, love.math.random(window.height)) 
end
i,j = 1,0
timer = 0
timer2 = 0

end

function love.update(dt)

timer = timer + dt*15
if (timer > 0.5) and (i <= count-1) then
	timer2 = timer2 + dt*15
	if timer2 > 0.5 and (j<count-i)then
		j = j + 1
		if values[j]>values[j+1] then
			local temp = values[j]
			values[j] = values[j+1]
			values[j+1] = temp
		end
		timer2 = 0
	end
	if j == count-i then
		i = i + 1
		j = 0
	end
	timer = 0
end

end

function love.draw()

love.graphics.setLineWidth(stroke)
love.graphics.translate(stroke/2, 0)
for i,v in ipairs(values) do
	love.graphics.setColor(1, 1, 1)
	love.graphics.line((i-1)*stroke, window.height, (i-1)*stroke,window.height-v)
	love.graphics.setColor(1, 0.5,1)
end
love.graphics.print(j)
love.graphics.print(i, 0, 20)
end

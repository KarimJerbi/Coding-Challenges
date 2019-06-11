-- #140 Pi:Leibniz - Karim Jerbi(@apolius)

function love.load()
love.window.setTitle('Pi : Leibniz')
window = {}
window.width = love.graphics.getWidth()
window.height = love.graphics.getHeight()

pi = 4
i = 0
j = -1
pies = {0,0}
x= 0
function scale(x)
	Q = math.pi - x	    
	return Q * window.height
end

end

function love.update()
d = i * 2 + 3
if (i % 2) == 0 then
    pi = pi -(4/d)
else
	pi = pi +(4/d) 
end

i = i + 1
j = j + 2
table.insert(pies, j, i*10)
table.insert(pies, j+1 , scale(pi))

if love.keyboard.isDown('right') then
	x = x - 10
elseif love.keyboard.isDown('left') and x ~= 0 then
	x = x+10
end
end

function love.draw()
love.graphics.setLineWidth(1.5)
love.graphics.setLineJoin('bevel')
love.graphics.translate(0, window.height/2)
love.graphics.translate(x,0)
love.graphics.line(pies)
love.graphics.print(pi, window.width-125-x, 100)
end

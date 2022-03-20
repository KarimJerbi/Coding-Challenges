function love.load()
love.window.setTitle('Prime Spiral')
lg = love.graphics
state = 0
step, turnCounter, numSteps = 1, 1, 1
stepSize = 4
width, height = lg.getPixelDimensions()
cols = math.ceil(width/stepSize)
rows = math.ceil(height/stepSize)
totalSteps = cols*rows
x = (cols/2)*stepSize
y = ((rows/2)+1)*stepSize

function isPrime(n)
    if  n == 1 then
	return false
    end
    for i = 2, n^(1/2) do
        if (n % i) == 0 then
            return false
        end
    end
    return true
end

points = {}
function newPoint(x, y, p)
    local point = {}
    point.x=x
    point.y=y
    point.p=isPrime(step)
    table.insert(points, point)
end
end

function love.update()
  newPoint(x,y,step)
  if step < totalSteps then
    if state == 0 then
      x = x + stepSize
    elseif state == 1 then
      y = y - stepSize
    elseif state == 2 then
      x = x - stepSize
    elseif state == 3 then
      y = y + stepSize
    end
    if step % numSteps == 0 then
      state = (state + 1) % 4
      turnCounter = turnCounter + 1
      if turnCounter % 2 == 0 then
      	numSteps = numSteps + 1
      end
    end
    step = step + 1
  end

end

function love.draw()
  for ko,point in ipairs(points) do
 	if point.p then
    	lg.setColor(1,1,1)
    	lg.circle('fill',point.x-stepSize/2,point.y-stepSize/2,stepSize/2)
  	end
  end
end

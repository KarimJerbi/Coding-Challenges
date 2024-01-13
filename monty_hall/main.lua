-- #170 The Monty Hall Problem - Karim Jerbi(@apolius)
function love.load()
	love.window.setTitle('Monty Hall')
    love.math.setRandomSeed(os.time())

    goat = love.graphics.newImage("goat.png")
    train = love.graphics.newImage("train.png")
    
    doors = {}
    doorCount = 3
    selectedDoor = 0
    revealedDoor = 0

    totalSwitchPlays = 0
    totalStayPlays = 0
    totalSwitchWins = 0
    totalStayWins = 0
    
    function init()
        for i = 1, doorCount do -- reset all doors 
            doors[i] = { prize = false, open = false }
        end 
        local prizeDoor = math.random(doorCount) -- randomly place the prize again 
        doors[prizeDoor].prize = true 
        gameState = "choose"
        firstDoor = 0
    end

    function endGame()
        for j, otherDoor in ipairs(doors) do otherDoor.open = true end
        gameState = "end"
    end
    init()
end

function love.update()
function love.mousepressed(x, y, button)
    if button == 1 or button == 2 then
        if gameState == "choose" then
            for i, door in ipairs(doors) do
                local doorX = i * 100
                local doorY = 100
                if x > doorX and x < doorX + 80 and y > doorY and y < doorY + 120 then -- clicked on a door
                    selectedDoor = i
                    firstDoor = i
                    -- reveal a non-prize door that is not the selected door
                    local revealOptions = {}
                    for j, otherDoor in ipairs(doors) do
                    -- not the selected door and not the prize door
                        if j ~= selectedDoor and not otherDoor.prize then 
                            table.insert(revealOptions, j)
                        end
                    end
                    revealedDoor = revealOptions[math.random(#revealOptions)]
                    doors[revealedDoor].open = true
                    gameState = "switch"
                end
            end
        elseif gameState == "switch" then -- switch or stay?
            for i, door in ipairs(doors) do -- check if clicked on a closed door
                local doorX = i * 100
                local doorY = 100
                if x > doorX and x < doorX + 80 and y > doorY and y < doorY + 120 and not door.open then
                    selectedDoor = i
                    if firstDoor == selectedDoor then
                    --staying
                        totalStayPlays = totalStayPlays + 1
                        if doors[selectedDoor].prize then
                            totalStayWins = totalStayWins + 1
                        end
                    else
                    -- switching
                        totalSwitchPlays = totalSwitchPlays + 1
                        if doors[selectedDoor].prize then
                            totalSwitchWins = totalSwitchWins + 1
                        end
                    end
                    selectedDoor = i -- switch to the new selected door
                    endGame()
                end
            end
        elseif gameState == "end" then
            init()
        end
    end 
end 
end

function love.draw()
    for i, door in ipairs(doors) do
        local x = i * 100
        local y = 100
        if door.open then
            if door.prize then
                love.graphics.setColor(0, 1, 0)
                love.graphics.rectangle("fill", x, y, 80, 120)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(train, x, y/2+60)
            else
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", x, y, 80, 120)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(goat, x, y/2+60)
            end
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", x, y, 80, 120)
        end
    end
    if gameState == "choose" then
        love.graphics.print("Choose a door", 10, 10)
    elseif gameState == "switch" then
        love.graphics.print("Switch or stay?", 10, 10)
    elseif gameState == "end" then
        if doors[selectedDoor].prize then
            love.graphics.print("You won!", 10, 10)
        else
            love.graphics.print("You lost!", 10, 10)
        end
    end
    love.graphics.print("Total Switch Plays : "..totalSwitchPlays, 10, 30)
    love.graphics.print("Total Stay Plays : "..totalStayPlays, 160, 30)
    love.graphics.print("Total Switch Wins : "..totalSwitchWins, 10, 50)
    love.graphics.print("Total Stay Wins : "..totalStayWins, 160, 50)
    local percentage = (totalSwitchWins/totalSwitchPlays)*100
    love.graphics.print("Switch Winrate : "..string.format("%.2f",percentage).."%", 100, 70)
end

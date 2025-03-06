function love.load()
	love.window.setTitle('Monty Hall')
    love.math.setRandomSeed(os.time())

    GOAT = love.graphics.newImage("Goat.png")
    TRAIN = love.graphics.newImage("Train.png")

    Doors = {}
    DoorCount = 3
    SelectedDoor = 0
    RevealedDoor = 0

    TotalSwitchPlays = 0
    TotalStayPlays = 0
    TotalSwitchWins = 0
    TotalStayWins = 0

    GameState = "choose"
    FirstDoor = 0

    function INIT()
        for i = 1, DoorCount do -- reset all Doors
            Doors[i] = { prize = false, open = false }
        end
        local prizeDoor = math.random(DoorCount) -- randomly place the prize again
        Doors[prizeDoor].prize = true
        GameState = "choose"
        FirstDoor = 0
    end

    function EndGame()
        for _, otherDoor in ipairs(Doors) do otherDoor.open = true end
        GameState = "end"
    end
    INIT()
end

function love.mousepressed(x, y, button)
    if button == 1 or button == 2 then
        if GameState == "choose" then
            for i, door in ipairs(Doors) do
                local doorX = i * 100
                local doorY = 100
                if x > doorX and x < doorX + 80 and y > doorY and y < doorY + 120 then -- clicked on a door
                    SelectedDoor = i
                    FirstDoor = i
                    -- reveal a non-prize door that is not the selected door
                    local revealOptions = {}
                    for j, otherDoor in ipairs(Doors) do
                    -- not the selected door and not the prize door
                        if j ~= SelectedDoor and not otherDoor.prize then
                            table.insert(revealOptions, j)
                        end
                    end
                    RevealedDoor = revealOptions[math.random(#revealOptions)]
                    Doors[RevealedDoor].open = true
                    GameState = "switch"
                end
            end
        elseif GameState == "switch" then -- switch or stay?
            for i, door in ipairs(Doors) do -- check if clicked on a closed door
                local doorX = i * 100
                local doorY = 100
                if x > doorX and x < doorX + 80 and y > doorY and y < doorY + 120 and not door.open then
                    SelectedDoor = i
                    if FirstDoor == SelectedDoor then
                    --staying
                        TotalStayPlays = TotalStayPlays + 1
                        if Doors[SelectedDoor].prize then
                            TotalStayWins = TotalStayWins + 1
                        end
                    else
                    -- switching
                        TotalSwitchPlays = TotalSwitchPlays + 1
                        if Doors[SelectedDoor].prize then
                            TotalSwitchWins = TotalSwitchWins + 1
                        end
                    end
                    SelectedDoor = i -- switch to the new selected door
                    EndGame()
                end
            end
        elseif GameState == "end" then
            INIT()
        end
    end
end

function love.draw()
    for i, door in ipairs(Doors) do
        local x = i * 100
        local y = 100
        if door.open then
            if door.prize then
                love.graphics.setColor(0, 1, 0)
                love.graphics.rectangle("fill", x, y, 80, 120)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(TRAIN, x, y/2+60)
            else
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", x, y, 80, 120)
                love.graphics.setColor(1, 1, 1)
                love.graphics.draw(GOAT, x, y/2+60)
            end
        else
            love.graphics.setColor(1, 1, 1)
            love.graphics.rectangle("line", x, y, 80, 120)
        end
    end
    if GameState == "choose" then
        love.graphics.print("Choose a door", 10, 10)
    elseif GameState == "switch" then
        love.graphics.print("Switch or stay?", 10, 10)
    elseif GameState == "end" then
        if Doors[SelectedDoor].prize then
            love.graphics.print("You won!", 10, 10)
        else
            love.graphics.print("You lost!", 10, 10)
        end
    end
    love.graphics.print("Total Switch Plays : "..TotalSwitchPlays, 10, 30)
    love.graphics.print("Total Stay Plays : "..TotalStayPlays, 160, 30)
    love.graphics.print("Total Switch Wins : "..TotalSwitchWins, 10, 50)
    love.graphics.print("Total Stay Wins : "..TotalStayWins, 160, 50)
    local percentage = (TotalSwitchWins/TotalSwitchPlays)*100
    love.graphics.print("Switch Winrate : "..string.format("%.2f",percentage).."%", 100, 70)
end
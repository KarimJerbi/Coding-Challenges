local delaunay = require("delaunay")

local width, height
local points = {}
local voronoi
local image, imageData
local debugLog = {}

function love.load()
    love.window.setTitle("Weighted Voronoi Stippling")
    width, height = 600, 600
    love.window.setMode(width, height)
    
    -- Load image
    local success, result = pcall(function()
        image = love.graphics.newImage("dog.png")
        imageData = love.image.newImageData("dog.png")
        return true
    end)
    
    if not success then
        addToDebugLog("Error loading image: " .. tostring(result))
        return
    end
    
    addToDebugLog("Image loaded successfully. Dimensions: " .. image:getWidth() .. "x" .. image:getHeight())
    
    -- Scale image if necessary
    local scale = math.min(width / image:getWidth(), height / image:getHeight())
    scaledWidth = image:getWidth() * scale
    scaledHeight = image:getHeight() * scale
    
    -- Initialize points
    initializePoints()
    
    -- Initial Delaunay triangulation and Voronoi diagram
    updateVoronoi()
end

function initializePoints()
    local numPoints = 100 -- Further reduced number of points
    local minDistance = 15 -- Further increased minimum distance
    local maxAttempts = 1000
    
    points = {}
    for i = 1, numPoints do
        local attempts = 0
        while attempts < maxAttempts do
            local x = love.math.random(scaledWidth) + (width - scaledWidth) / 2
            local y = love.math.random(scaledHeight) + (height - scaledHeight) / 2
            local newPoint = delaunay.Point(x, y)
            
            local tooClose = false
            for _, p in ipairs(points) do
                if distanceBetween(newPoint, p) < minDistance then
                    tooClose = true
                    break
                end
            end
            
            if not tooClose then
                table.insert(points, newPoint)
                break
            end
            
            attempts = attempts + 1
        end
        
        if attempts == maxAttempts then
            addToDebugLog("Warning: Could not place point " .. i .. " after " .. maxAttempts .. " attempts")
        end
    end
    
    addToDebugLog("Initialized " .. #points .. " points")
end

function distanceBetween(p1, p2)
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y
    return math.sqrt(dx * dx + dy * dy)
end

function updateVoronoi()
    local success = false
    local attempts = 0
    local maxAttempts = 50
    
    while not success and attempts < maxAttempts do
        attempts = attempts + 1
        
        success, voronoi = pcall(function()
            local triangles = delaunay.triangulate(unpack(points))
            return delaunay.voronoi(triangles, 0, 0, width, height)
        end)
        
        if not success then
            addToDebugLog("Voronoi generation attempt " .. attempts .. " failed: " .. tostring(voronoi))
            -- If triangulation failed, slightly adjust all points
            for i = 1, #points do
                points[i].x = points[i].x + love.math.random(-2, 2)
                points[i].y = points[i].y + love.math.random(-2, 2)
                -- Ensure points stay within bounds
                points[i].x = math.max(0, math.min(width, points[i].x))
                points[i].y = math.max(0, math.min(height, points[i].y))
            end
        else
            addToDebugLog("Voronoi generation successful on attempt " .. attempts)
        end
    end
    
    if not success then
        addToDebugLog("Failed to generate Voronoi diagram after " .. maxAttempts .. " attempts")
        addToDebugLog("Reinitializing points...")
        initializePoints()
        updateVoronoi()
    end
end

function love.update(dt)
    updatePoints()
end

function updatePoints()
    if not voronoi then 
        addToDebugLog("Skipping point update: voronoi is nil")
        return 
    end
    
    -- Rest of the updatePoints function remains the same
    -- ...
end

function addToDebugLog(message)
    table.insert(debugLog, os.date("%H:%M:%S") .. ": " .. message)
    print(debugLog[#debugLog]) -- Also print to console
    if #debugLog > 20 then
        table.remove(debugLog, 1) -- Keep only the last 20 messages
    end
end

function love.draw()
    if image then
        love.graphics.setColor(1, 1, 1, 0.3)
        love.graphics.draw(image, (width - scaledWidth) / 2, (height - scaledHeight) / 2, 0, scale, scale)
    end
    
    if points then
        love.graphics.setColor(0, 0, 0)
        for _, point in ipairs(points) do
            love.graphics.circle("fill", point.x, point.y, 1)
        end
    end
    
    if voronoi then
        love.graphics.setColor(1, 0, 0, 0.1)
        for _, cell in ipairs(voronoi.cells) do
            local vertices = {}
            for _, point in ipairs(cell) do
                table.insert(vertices, point.x)
                table.insert(vertices, point.y)
            end
            love.graphics.polygon("line", vertices)
        end
    end
    
    -- Draw debug log
    love.graphics.setColor(0, 0, 0, 1)
    for i, message in ipairs(debugLog) do
        love.graphics.print(message, 10, 10 + (i-1) * 20)
    end
end

function love.keypressed(key)
    if key == "s" then
        local debugText = table.concat(debugLog, "\n")
        love.filesystem.write("debug_log.txt", debugText)
        print("Debug log saved to debug_log.txt")
    end
end
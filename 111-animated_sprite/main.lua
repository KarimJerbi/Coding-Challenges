-- #111 Animated Sprite - Karim Jerbi(@KarimJerbi)

local spritesheet = {}
local animation = {}
local horses = {}

Sprite = {}
Sprite.__index = Sprite

function Sprite:new(animation, x, y, speed)
    local self = setmetatable({}, Sprite)
    self.x = x
    self.y = y
    self.animation = animation
    self.w = 192
    self.len = #animation
    self.speed = speed
    self.index = 0
    return self
end

function Sprite:show()
    local index = math.floor(self.index) % self.len
    love.graphics.draw(spritesheet, self.animation[index + 1], self.x, self.y)
end

function Sprite:animate()
    self.index = self.index + self.speed
    self.x = self.x + self.speed * 15

    if self.x > love.graphics.getWidth() then
    self.x = -self.w
    end
end

function love.load()
    love.window.setTitle("Animated Sprite")
    love.window.setMode(640, 576)

    spritesheet = love.graphics.newImage("horse.png")

    local frames = {
    { position = { x = 0, y = 0} },
    { position = { x = 192, y = 0}},
    { position = { x = 384, y = 0}},
    { position = { x = 0, y = 144}},
    { position = { x = 192, y = 144}},
    { position = { x = 0, y = 288}},
    { position = { x = 384, y = 144}},
    }


    for i = 1, #frames do
    local pos = frames[i].position
    local img = love.graphics.newQuad(pos.x, pos.y, 192, 144, spritesheet:getWidth(), spritesheet:getHeight())
    table.insert(animation, img)
    end

    for i = 1, 5 do
    horses[i] = Sprite:new(animation, 0, (i - 1) * 144, love.math.random(1, 4) / 10)
    end
end

function love.draw()
    love.graphics.clear(0, 0, 0)

    for _, horse in ipairs(horses) do
    horse:show()
    horse:animate()
    end
end

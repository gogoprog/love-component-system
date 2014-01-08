require 'lcs.engine'

-- Locals

local description = {
    {
        Type = "SPRITE",
        Properties = {
            Texture = love.graphics.newImage("data/texture.png"),
            Extent = {64,64},
            Layer = 11
        }
    },
    {
        Type = "SPRITE",
        Properties = {
            Texture = love.graphics.newImage("data/texture.png"),
            Extent = {256,256},
            Layer = 3
        }
    }
}

-- Callbacks

local obj

function love.load()
    obj = ENTITY(description,{400,400})
end

function love.update(dt)
    obj.Orientation = obj.Orientation + dt

    ENGINE.Update(dt)
end

function love.draw()
    ENGINE.Render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
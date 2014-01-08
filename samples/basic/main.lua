require 'lcs.engine'

-- Locals

ObjectDescription = {
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
    obj = ENTITY(ObjectDescription,{400,400})
end

function love.update(dt)
    ENGINE.Update(dt)
    obj.Orientation = obj.Orientation + dt
end

function love.draw()
    ENGINE.Render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
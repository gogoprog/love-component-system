require 'lcs.engine'

-- Locals

ObjectDescription = {
    SPRITE = {
        Texture = love.graphics.newImage("data/texture.png"),
        Extent = {256,256}
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
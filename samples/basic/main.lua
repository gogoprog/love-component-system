require 'lcs.entity'
require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_animated_sprite'

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
    ENTITY.UpdateAll(dt)
    obj.Orientation = obj.Orientation + dt
end

function love.draw()
    ENTITY.RenderAll()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
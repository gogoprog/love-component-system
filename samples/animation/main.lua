require 'lcs.entity'
require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_animated_sprite'
require 'lcs.animation'

local obj

function love.load()
    ANIMATION.Create("ken",{
        Source = love.graphics.newImage("data/ken.png"),
        CellWidth = 70,
        CellHeight = 80,
        Frames = { 0, 1, 2, 3 },
        FrameRate = 4
        })

    local description = {
        ANIMATED_SPRITE = {
            Animation = ANIMATION.Get("ken")
        }
    }

    obj = ENTITY(description,{400,400})
end

function love.update(dt)
    ENTITY.UpdateAll(dt)
end

function love.draw()
    ENTITY.RenderAll()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
require 'lcs.engine'

local obj

function love.load()
    ANIMATION.Create("ken",{
        Source = love.graphics.newImage("data/ken.png"),
        CellWidth = 70,
        CellHeight = 80,
        Frames = { 0, 1, 2, 3 },
        FrameRate = 12
        })

    local description = {
        ANIMATED_SPRITE = {
            Animation = ANIMATION.Get("ken")
        }
    }

    obj = ENTITY(description,{400,400})
end

function love.update(dt)
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
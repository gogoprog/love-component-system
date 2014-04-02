require 'lcs.engine'

function love.load()
    ANIMATION.Create("ken",{
        Source = love.graphics.newImage("data/ken.png"),
        CellWidth = 70,
        CellHeight = 80,
        Frames = { 0, 1, 2, 3 },
        FrameRate = 8
        })

    local description = {
        {
            Type= "ANIMATED_SPRITE",
            Properties = {
                Animation = ANIMATION.Get("ken"),
                Extent = { 256, 256 }
            }
        }
    }

    ENTITY(description,{400,300})
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
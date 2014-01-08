require 'lcs.engine'

-- Locals

local description = {
    {
        Type = "TEXT",
        Properties = {
            Text = "love-component-system"
        }
    }
}

-- Callbacks

local obj

function love.load()
    obj = ENTITY(description,{400,300})
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
require 'lcs.engine'

-- Locals

local description = {
    {
        Type = "TEXT",
        Properties = {
            Text = "love-component-system",
            Extent = {312,64}
        }
    }
}

-- Callbacks

local entity

function love.load()
    entity = ENTITY(description,{400,300})
end

function love.update(dt)
    entity.Orientation = entity.Orientation + dt

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
require 'lcs.engine'

require 'game'

local game = GAME()

function love.load()
    game:Initialize()
end

function love.update(dt)
    game:Update(dt)
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
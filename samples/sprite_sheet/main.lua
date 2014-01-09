require 'lcs.engine'

-- Locals

local sprite_sheet = SPRITE_SHEET(love.graphics.newImage("data/tile_set.png"),32,32)

sprite_sheet:AddQuad("grass",0,20,1,1)

local description = {
    World = {
        {
            Type = "SPRITE_BATCH",
            Properties = {
                SpriteSheet = sprite_sheet,
            }
        }
    },
    Grass = {
        {
            Type = "STATIC_SPRITE",
            Properties = {
                Quad = sprite_sheet:GetQuad("grass")
            }
        }
    }
}
-- Callbacks

function love.load()
    local world = ENTITY(description.World,{0,0})

    world:Bind()

    ENTITY(description.Grass,{400,300})
    ENTITY(description.Grass,{432,300})

    world:Unbind()
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
require 'lcs.engine'

-- Locals

local sprite_sheet = SPRITE_SHEET(love.graphics.newImage("data/tile_set.png"),64,64)

sprite_sheet:AddQuad("grass",0,0,1,1)
sprite_sheet:AddQuad("tree",0,6,1,1)

local description = {
    World = {
        {
            Type = "SPRITE_BATCH",
            Properties = {
                SpriteSheet = sprite_sheet,
            }
        }
    }
}
-- Callbacks

function love.load()
    local world = ENTITY(description.World,{0,0})

    world:Bind()

    for x=0,400,32 do
        for y=0,400,32 do

            local isox = x - y;
            local isoy = (x + y) / 2;

            if math.random() > 0.06 then
                world:AddSpriteQuad(sprite_sheet:GetQuad("grass"),isox,isoy)
            else
                world:AddSpriteQuad(sprite_sheet:GetQuad("tree"),isox,isoy)
            end
        end
    end

    world:Unbind()
end

function love.update(dt)

    ENGINE.Update(dt)
end

function love.draw()
    love.graphics.translate(400,100)
    ENGINE.Render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
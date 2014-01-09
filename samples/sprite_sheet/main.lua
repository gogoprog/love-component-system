require 'lcs.engine'

-- Locals

local sprite_sheet = SPRITE_SHEET(love.graphics.newImage("data/tile_set.png"),32,32)

sprite_sheet:AddQuad("grass",0,20,1,1)
sprite_sheet:AddQuad("tree",2,20,1,1)
sprite_sheet:AddQuad("building",0,10,4,5)


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
    },
    Tree = {
        {
            Type = "STATIC_SPRITE",
            Properties = {
                Quad = sprite_sheet:GetQuad("tree")
            }
        }
    },
    Building = {
        {
            Type = "STATIC_SPRITE",
            Properties = {
                Quad = sprite_sheet:GetQuad("building")
            }
        }
    }
}
-- Callbacks

function love.load()
    local world = ENTITY(description.World,{0,0})

    world:Bind()

    for x=0,800,32 do
        for y=0,600,32 do
            if math.random() < 0.06 then
                ENTITY(description.Tree,{x,y})
            else
                ENTITY(description.Grass,{x,y})
            end
        end
    end

    ENTITY(description.Building,{512,256})

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
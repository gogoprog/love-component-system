require "block"

LEVEL = class(function(o)
    o.SpriteSheet = SPRITE_SHEET.Get("main")
    o.CellSize = 32
end)

function LEVEL:Initialize(game)
    local descriptions = {
        World = {
            {
                Type = "BOUNDING_WORLD",
                Properties = {
                }
            },
            {
                Type = "SPRITE_BATCH",
                Properties = {
                    SpriteSheet = self.SpriteSheet,
                }
            }
        },
        Grass = {
            {
                Type = "STATIC_SPRITE",
                Properties = {
                    Quad = self.SpriteSheet:GetQuad("grass")
                }
            }
        },
        Block = {
            {
                Type = "STATIC_SPRITE",
                Properties = {
                    Quad = self.SpriteSheet:GetQuad("block")
                }
            },
            {
                Type = "BOUNDING",
                Properties = {
                    Shape = "rectangle",
                    Extent = {32,32}
                }
            }
        }
    }

    self.World = ENTITY(descriptions.World)

    self.World:Bind()

    local grass_quad = self.SpriteSheet:GetQuad("grass")

    for x=0,800,32 do
        for y=0,600,32 do
            self.World:AddSpriteQuad(grass_quad,x,y)
        end
    end

    for x=32,768,96 do
        for y=32,512,96 do
            ENTITY(descriptions.Block,{x,y})
            game:BlockGrid(x,y)
        end
    end

    for x=32,768,32 do
        for y=32,600,512 do
            ENTITY(descriptions.Block,{x,y})
            game:BlockGrid(x,y)
        end
    end

    for y=32,512,32 do
        for x=32,768,736 do
            ENTITY(descriptions.Block,{x,y})
            game:BlockGrid(x,y)
        end
    end

    game:PlaceBlock(3,4)
    game:PlaceBlock(3,5)
    game:PlaceBlock(3,6)

    self.World:Unbind()
end

function LEVEL:GetCorrectedPosition(x,y)
    local rx,ry
    local cs = self.CellSize

    rx = math.floor((x+cs/2) / cs) * cs
    ry = math.floor((y+cs/2) / cs) * cs

    return rx,ry
end

function LEVEL:GetGridPosition(x,y)
    local gx,gy
    local cs = self.CellSize

    gx = math.floor((x+cs/2) / cs)
    gy = math.floor((y+cs/2) / cs)

    return gx,gy
end
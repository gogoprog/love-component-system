LEVEL = class(function(o)
    o.SpriteSheet = SPRITE_SHEET(love.graphics.newImage("data/tile_set.png"),32,32)

    o.SpriteSheet:AddQuad("grass",0,20,1,1)
    o.SpriteSheet:AddQuad("tree",2,20,1,1)
    o.SpriteSheet:AddQuad("building",0,10,4,5)
end)

function LEVEL:Initialize()
    local descriptions = {
        World = {
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
        }
    }

    self.World = ENTITY(descriptions.World)

    self.World:Bind()

    local grass_quad = self.SpriteSheet:GetQuad("grass")

    for x=0,800,32 do
        for y=0,600,32 do
            self.World.SpriteBatch:add(grass_quad,x,y)
        end
    end

    self.World:Unbind()
end

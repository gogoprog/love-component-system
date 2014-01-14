LEVEL = class(function(o)
    o.SpriteSheet = SPRITE_SHEET(love.graphics.newImage("data/tile_set.png"),32,32)

    o.SpriteSheet:AddQuad("grass",0,20,1,1)
    o.SpriteSheet:AddQuad("tree",2,20,1,1)
    o.SpriteSheet:AddQuad("block",3,0,1,1)

    o.CellSize = 32
end)

function LEVEL:Initialize(game)
    local descriptions = {
        World = {
            {
                Type = "PHYSIC_WORLD",
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
                Type = "PHYSIC",
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
            self.World.SpriteBatch:add(grass_quad,x,y)
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

    self.World:Unbind()
end


function LEVEL:Collides(x,y,w,h)
    local hw, hh = w*0.5, h*0.5

    if self.World:RayTestFirst(x,y,x - hw,y - hh) ~= nil then
        return true
    end

    if self.World:RayTestFirst(x,y,x + hw,y - hh) ~= nil then
        return true
    end

    if self.World:RayTestFirst(x,y,x-hw,y+hh) ~= nil then
        return true
    end

    if self.World:RayTestFirst(x,y,x+hw,y+hh) ~= nil then
        return true
    end

    return false
end

function LEVEL:GetCorrectedPosition(x,y)
    local rx,ry
    local cs = self.CellSize

    rx = math.floor((x+cs/2) / cs) * cs
    ry = math.floor((y+cs/2) / cs) * cs

    return rx,ry
end

function LEVEL:GetGridPosition(x,y)
    local rx,ry
    local cs = self.CellSize

    rx = math.floor((x+cs/2) / cs)
    ry = math.floor((y+cs/2) / cs)

    return rx,ry
end
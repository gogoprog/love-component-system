LEVEL = class(function(o)
    o.ObstacleHeight = 4*4*15
end)

function LEVEL:Load(game)
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
                    SpriteSheet = SPRITE_SHEET.Get("tiles")
                }
            }
        },
        Sky = {
            {
                Type = "SPRITE_BATCH",
                Properties = {
                    SpriteSheet = SPRITE_SHEET.Get("sky")
                }
            }
        },
        Block = {
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "rectangle",
                    Extent = {10240,4*15},
                    Type = "static"
                }
            }
        },
        Obstacle = {
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "rectangle",
                    Extent = {4*15,self.ObstacleHeight},
                    Type = "static"
                }
            }
        },
    }

    self.Sky = ENTITY(descriptions.Sky)
    self.World = ENTITY(descriptions.World)
    self.Ceiling = ENTITY(descriptions.Block,{0,0})
    self.Floor = ENTITY(descriptions.Block,{0,570})


    self:GenerateSky()
    self:GenerateBlocks(descriptions)
end

function LEVEL:GenerateSky()
    local ss = SPRITE_SHEET.Get("sky")
    local q = ss:GetQuad("cloud")
    local sky = self.Sky

    sky:Bind()
    for i=1,100 do
        sky:AddSpriteQuad(q,200 + i * 150,math.random(0,600),0,math.random(4,6),math.random(4,6))
    end
    sky:Unbind()
end

function LEVEL:GenerateBlocks(descriptions)
    local ss = SPRITE_SHEET.Get("tiles")
    local q = ss:GetQuad("block")
    local w = self.World

    w:Bind()
    for i=1,100 do
        w:AddSpriteQuad(q, i * 4 * 15,0,0,4,-4)
        w:AddSpriteQuad(q, i * 4 * 15,570,0,4,4)
    end

    local lastx = 0
    local y
    for i=1,10 do
        local x = lastx + i * 4 * 15 * math.random(2,4)
        local center = math.random(250,350)

        y = center-self.ObstacleHeight
        w:AddSpriteQuad(q, x,y,0,4,16)
        ENTITY(descriptions.Obstacle,{x,y})

        y = center+self.ObstacleHeight
        w:AddSpriteQuad(q, x,y,0,4,16)
        ENTITY(descriptions.Obstacle,{x,y})

        lastx = x
    end

    w:Unbind()
end

function LEVEL:Update(dt)
    local skypos = self.Sky.Position
    skypos[1] = skypos[1] + dt * 100
end
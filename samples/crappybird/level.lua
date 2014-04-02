LEVEL = class(function(o)
    o.ObstacleHeight = 256
    o.Obstacles = {}
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
                    SpriteSheet = SPRITE_SHEET.Get("tiles"),
                    Size = 10240
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
                Type = "SPRITE",
                Properties = {
                    Texture = TEXTURE.Get("pipe"),
                    Extent = {64,self.ObstacleHeight}
                }
            },
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "rectangle",
                    Extent = {64,self.ObstacleHeight},
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

    self.Obstacles = {}

    w:Bind()
    for i=1,1000 do
        w:AddSpriteQuad(q, i * 4 * 15,0,0,4,-4)
        w:AddSpriteQuad(q, i * 4 * 15,570,0,4,4)
    end

    local lastx = 4 * 15 * 10
    local y
    for i=1,100 do
        local x = lastx + 4 * 15 * math.random(5,10)
        local center = math.random(150,450)

        y = center-self.ObstacleHeight * 0.85
        --w:AddSpriteQuad(q, x,y,0,4,32)
        ENTITY(descriptions.Obstacle,{x,y})

        y = center+self.ObstacleHeight *0.85
        --w:AddSpriteQuad(q, x,y,0,4,32)
        ENTITY(descriptions.Obstacle,{x,y})

        lastx = x

        table.insert(self.Obstacles, x)
    end

    w:Unbind()
end

function LEVEL:Update(dt)
    local skypos = self.Sky.Position
    skypos[1] = skypos[1] + dt * 100
end

function LEVEL:GetScore(x)
    local res = 0
    for k,v in ipairs(self.Obstacles) do
        if x > v + 35 then
            res = res + 10
        else
            return res
        end
    end
end
LEVEL = class(function(o)
    o.ObstacleHeight = 512
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
                    SpriteSheet = SPRITE_SHEET.Get("floors"),
                    Size = 10240
                }
            }
        },
        Ceilings = {
             {
                Type = "SPRITE_BATCH",
                Properties = {
                    SpriteSheet = SPRITE_SHEET.Get("ceilings"),
                    Size = 10240
                }
            }
        },
        VisualObstacles = {
             {
                Type = "SPRITE_BATCH",
                Properties = {
                    SpriteSheet = SPRITE_SHEET.Get("obstacles"),
                    Size = 10240
                }
            }
        },
        VisualObstaclesV = {
             {
                Type = "SPRITE_BATCH",
                Properties = {
                    SpriteSheet = SPRITE_SHEET.Get("obstacles_v"),
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
                    Extent = {102400,4*15},
                    Type = "static"
                }
            }
        },
        Obstacle = {
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "rectangle",
                    Extent = {64,self.ObstacleHeight},
                    Type = "static"
                }
            }
        },
        ObstacleV = {
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "rectangle",
                    Extent = {64,self.ObstacleHeight},
                    Type = "static"
                }
            }
        }
    }

    self.Sky = ENTITY(descriptions.Sky)
    self.World = ENTITY(descriptions.World)
    self.Ceilings = ENTITY(descriptions.Ceilings)

    self.Ceiling = ENTITY(descriptions.Block,{0,0})
    self.Floor = ENTITY(descriptions.Block,{0,570})


    self.VisualObstacles = ENTITY(descriptions.VisualObstacles)
    self.VisualObstaclesV = ENTITY(descriptions.VisualObstaclesV)


    self:GenerateSky()
    self:GenerateBlocks(descriptions)
end

function LEVEL:GenerateSky()
    local ss = SPRITE_SHEET.Get("sky")
    local q = ss:GetQuad("cloud")
    local sky = self.Sky

    sky:Bind()
    for i=1,64 do
        sky:AddSpriteQuad(q,200 + i * 350,math.random(0,600),0,math.random(6,11),math.random(4,6))
    end
    sky:Unbind()
end

function LEVEL:GenerateBlocks(descriptions)
    local ss = SPRITE_SHEET.Get("floors")
    local q = ss:GetQuad("floor")
    local w = self.World

    self.Obstacles = {}

    w:Bind()

    for i=1,1024 do
        self.Ceilings:AddSpriteQuad(q, i*64,0,0,1,1)

        w:AddSpriteQuad(q, i*64,570,0,1,1)
    end

    w:Unbind()

    ss = SPRITE_SHEET.Get("obstacles")
    q = ss:GetQuad("obstacle")

    local lastx = 4 * 15 * 10
    local y
    for i=1,100 do
        local x = lastx + 4 * 15 * math.random(5,10)
        local center = math.random(150,450)

        y = center-self.ObstacleHeight * 0.65
        self.VisualObstaclesV:AddSpriteQuad(q,x,y, 0, 1,1)
        ENTITY(descriptions.ObstacleV,{x,y})

        y = center+self.ObstacleHeight * 0.65
        self.VisualObstacles:AddSpriteQuad(q,x,y, 0, 1,1)
        ENTITY(descriptions.Obstacle,{x,y})

        lastx = x

        table.insert(self.Obstacles, x)
    end

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
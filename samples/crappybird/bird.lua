BIRD = entity_class(function(o)
    local description = {
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("bird"),
                Extent = {64,64},
                Layer = 3
            }
        },
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "circle",
                Radius = 30,
                Type = "dynamic"
            }
        },
        {
            Type = "PARTICLE",
            Properties = {
                Layer = 2
            }
        }
    }

    ENTITY.Init(o,description,{400,300})

    local ps = love.graphics.newParticleSystem(TEXTURE.Get("bird"), 30)
    ps:setEmissionRate(15)
    ps:setParticleLifetime(0.5)
    ps:setSizes(0.25)
    ps:setColors(255,255,255,255,0,0,0,0)

    o:AddParticleSystem(ps,false)
end)


function BIRD:Update(dt)

end

function BIRD:OnCollisionBegin(other)
    self.Game.GameOver = true
end

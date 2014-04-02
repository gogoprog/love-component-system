BIRD = entity_class(function(o)
    local description = {
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("bird_up"),
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

    local ps = love.graphics.newParticleSystem(TEXTURE.Get("bird_up"), 30)
    ps:setEmissionRate(15)
    ps:setParticleLifetime(0.5)
    ps:setSizes(0.25)
    ps:setColors(255,255,255,255,0,0,0,0)

    o:AddParticleSystem(ps,false)

    o.ItIsUp = true
    o.ItIsDead = false
end)


function BIRD:Update(dt)
    if not self.ItIsDead then
        local x,y = self:GetLinearVelocity()

        if y < 0 and not self.ItIsUp then
            self:SetSpriteTexture(TEXTURE.Get("bird_up"))
            self.ItIsUp = true
        end

        if y > 0 and self.ItIsUp then
            self:SetSpriteTexture(TEXTURE.Get("bird_down"))
            self.ItIsUp = false
        end
    else
        if not self.ItIsUp then
            self:SetSpriteTexture(TEXTURE.Get("lose_up"))
            self.ItIsUp = true
        elseif self.ItIsUp then
            self:SetSpriteTexture(TEXTURE.Get("lose_down"))
            self.ItIsUp = false
        end
    end
end

function BIRD:OnCollisionBegin(other)
    self.Game:GameOver()
    self.ItIsDead = true
end

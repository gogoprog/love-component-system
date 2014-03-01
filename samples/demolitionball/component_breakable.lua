require 'lcs.class'

COMPONENT_BREAKABLE= class(function(o,parameters,entity)
    o.Entity = entity
    o.Resistance = parameters.Resistance or 10000
end)

-- METHODS

function COMPONENT_BREAKABLE:Update(dt)
end

function COMPONENT_BREAKABLE:PreRender()

end

function COMPONENT_BREAKABLE:Render()
end

function COMPONENT_BREAKABLE:OnCollisionBegin(other)

end

function COMPONENT_BREAKABLE:OnCollisionPostSolve(other, impulse)
    if impulse > 200 then
        self.Resistance = self.Resistance - impulse

        if self.Resistance < 0 then
            self:CreateDebris()
            self.Entity:Destroy()
        end
    end
end

function COMPONENT_BREAKABLE:CreateDebris()
    local description = {
        {
            Type = "PARTICLE",
            Properties = {
                Layer = 5
            }
        },
        {
            Type = "LIFETIME",
            Properties = {
                Time = 1
            }
        }
    }

    local ps = love.graphics.newParticleSystem(TEXTURE.Get("cloud"), 30)
    ps:setEmissionRate(30)
    ps:setParticleLifetime(1.5)
    ps:setEmitterLifetime(1.5)
    ps:setSizes(0.5,1)
    ps:setColors(255,255,255,255,0,0,0,0)
    ps:setLinearAcceleration(100,1)
    ps:setSpread(0)
    ps:setSpin(20)
    ps:setDirection(0,180)

    local e = ENTITY(description,self.Entity.Position)
    e:AddParticleSystem(ps,true)
end
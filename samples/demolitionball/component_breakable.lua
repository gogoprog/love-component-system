require 'lcs.class'

COMPONENT_BREAKABLE= class(function(o,parameters,entity)
    o.Entity = entity
    o.Resistance = parameters.Resistance or 10000
    o.InitialResistance = o.Resistance
    o.TexturesNames = parameters.TexturesNames
    o.Shock = 0
end)

-- METHODS

function COMPONENT_BREAKABLE:Update(dt)
    local life = self.Resistance / self.InitialResistance

    local n = math.floor((( 1.0 - life ) * #self.TexturesNames)) + 1

    self.Entity:SetSpriteTexture(TEXTURE.Get(self.TexturesNames[n]))

    if self.Shock > 100 then
        self.Resistance = self.Resistance - self.Shock
        if self.Resistance < 0 then
            self:CreateDebris()
            self.Entity:Destroy()
        end
    end

    self.Shock = 0
end

function COMPONENT_BREAKABLE:PreRender()

end

function COMPONENT_BREAKABLE:Render()
end

function COMPONENT_BREAKABLE:OnCollisionBegin(other)

end

function COMPONENT_BREAKABLE:OnCollisionPostSolve(other, impulseA, impulseB)
    local vx,vy =  self.Entity:GetLinearVelocity()

    if math.abs(vy) < 1 then
        return
    end

    local impulse = impulseA + impulseB
    impulse = impulseB


    local density = self.Entity:GetFixture():getDensity()

    self.Shock = self.Shock + impulse/density
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

    local ps = love.graphics.newParticleSystem(TEXTURE.Get("cloud"), 100)
    ps:setEmissionRate(300)
    ps:setParticleLifetime(0.5)
    ps:setEmitterLifetime(0.2)
    ps:setSizes(0.5,1)
    ps:setColors(255,255,255,255,0,0,0,0)
    ps:setSpread(2 * 3.14)
    ps:setSpin(20)
    ps:setDirection(0)
    ps:setAreaSpread("uniform",self.Entity.Extent[1]/2,self.Entity.Extent[2]/2)

    local e = ENTITY(description,self.Entity.Position, self.Entity.Orientation)
    e:AddParticleSystem(ps)
end
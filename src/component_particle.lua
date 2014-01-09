require 'lcs.class'

COMPONENT_PARTICLE = class(function(o,parameters,entity)
    o.Entity = entity
    o.System = parameters.System
    o.Layer = parameters.Layer or 1
    o.KeepLocal = parameters.KeepLocal
end)

-- METHODS

function COMPONENT_PARTICLE:Update(dt)
    if not self.KeepLocal then
        local p = self.Entity.Position
        self.System:setPosition(p[1],p[2])
    end

    self.System:update(dt)
end

function COMPONENT_PARTICLE:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_PARTICLE:Render()

    if not self.KeepLocal then
        love.graphics.draw(
            self.System,
            0,
            0,
            0 -- self.Entity.Orientation -- Unsupported atm.
            )
    else
        local p = self.Entity.Position

        love.graphics.draw(
            self.System,
            p[1],
            p[2],
            self.Entity.Orientation
            )
    end
end

function COMPONENT_PARTICLE:SetKeepLocal(kl)
    self.KeepLocal = kl
end

function COMPONENT_PARTICLE:AddParticleSystem(ps)
    self.System = ps
end

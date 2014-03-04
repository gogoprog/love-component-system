require 'lcs.class'

COMPONENT_PARTICLE = class(function(o,parameters,entity)
    o.Entity = entity
    o.Systems = parameters.Systems or { parameters.System }
    o.Layer = parameters.Layer or 1
    o.KeepLocalTable = parameters.KeepLocalTable or {parameters.KeepLocal}
end)

-- METHODS

function COMPONENT_PARTICLE:Update(dt)
    for i,s in ipairs(self.Systems) do
        if not self.KeepLocalTable[i] then
            local p = self.Entity.Position
            s:setPosition(p[1],p[2])
        end

        s:update(dt)
    end
end

function COMPONENT_PARTICLE:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_PARTICLE:Render()
    local p = self.Entity.Position

    for i,s in ipairs(self.Systems) do
        if not self.KeepLocalTable[i] then
            love.graphics.draw(
                s,
                0,
                0,
                0 -- self.Entity.Orientation -- Unsupported atm.
                )
        else
            love.graphics.draw(
                s,
                p[1],
                p[2],
                self.Entity.Orientation
                )
        end
    end
end

function COMPONENT_PARTICLE:AddParticleSystem(input,keep_local)
    if type(input) == "userdata" then
        table.insert(self.Systems, input)
        table.insert(self.KeepLocalTable, keep_local)
    end
end
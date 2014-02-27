require 'lcs.class'

COMPONENT_BREAKABLE= class(function(o,parameters,entity)
    o.Entity = entity
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
    if impulse > 2000 then
        self.Entity:Destroy()
    end
end

require 'lcs.class'

COMPONENT_CAMERA = class(function(o,parameters,entity)
    o.Entity = entity
end)

-- METHODS

function COMPONENT_CAMERA:Update(dt)
end

function COMPONENT_CAMERA:PreRender()
    love.graphics.origin()

    local p = self.Entity.Position
    love.graphics.translate(-p[1],-p[2])
end

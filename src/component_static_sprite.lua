require 'lcs.class'

COMPONENT_STATIC_SPRITE = class(function(o,parameters,entity)
    o.Quad = parameters.Quad
    o.Entity = entity
    local p = entity.Position
    COMPONENT_SPRITE_BATCH.Current:add(parameters.Quad,p[1],p[2])
end)

-- METHODS

function COMPONENT_STATIC_SPRITE:Update()
end

function COMPONENT_STATIC_SPRITE:PreRender()
end
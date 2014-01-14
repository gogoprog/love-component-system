require 'lcs.class'

COMPONENT_STATIC_SPRITE = class(function(o,parameters,entity)
    o.Quad = parameters.Quad
    o.Entity = entity
    local p = entity.Position
    local x,y,w,h = o.Quad:getViewport()

    COMPONENT_SPRITE_BATCH.Current:add(
        parameters.Quad,
        p[1], p[2],
        entity.Orientation,
        1, 1,
        w * 0.5,
        h * 0.5
        )
end)

-- METHODS

function COMPONENT_STATIC_SPRITE:Update()
end

function COMPONENT_STATIC_SPRITE:PreRender()
end
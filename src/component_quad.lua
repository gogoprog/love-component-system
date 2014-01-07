require 'lcs.class'

COMPONENT_QUAD = class(function(o,parameters,entity)
    o.Extent = parameters.Extent
    o.Color = parameters.Color
    o.Entity = entity
    o.OffsetX = o.Extent[1] * 0.5
    o.OffsetY = o.Extent[2] * 0.5
end)

-- FUNCTIONS


-- METHODS

function COMPONENT_QUAD:Update()
end

function COMPONENT_QUAD:Render()
    love.graphics.rectangle(
        "fill",
        self.Entity.Position[1] - self.OffsetX,
        self.Entity.Position[2] - self.OffsetY,
        self.Extent[1],
        self.Extent[2]
        )
end


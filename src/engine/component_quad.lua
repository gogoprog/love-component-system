require 'engine.class'

COMPONENT_QUAD = class(function(o,parameters,entity)
    o.Extent = parameters.Extent
    o.Color = parameters.Color
    o.Entity = entity
end)

-- FUNCTIONS


-- METHODS

function COMPONENT_QUAD:Update()
end

function COMPONENT_QUAD:Render()
    love.graphics.rectangle(
        "fill",
        self.Entity.Position[1],
        self.Entity.Position[2],
        self.Extent[1],
        self.Extent[2]
        )
end


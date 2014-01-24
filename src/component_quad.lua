require 'lcs.class'

COMPONENT_QUAD = class(function(o,parameters,entity)
    o.Extent = parameters.Extent
    o.Color = parameters.Color or {255,255,255,255}
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.OffsetX = o.Extent[1] * 0.5
    o.OffsetY = o.Extent[2] * 0.5
end)

-- METHODS

function COMPONENT_QUAD:Update()
end

function COMPONENT_QUAD:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_QUAD:Render()
    love.graphics.setColor(self.Color)
    love.graphics.rectangle(
        "fill",
        self.Entity.Position[1] - self.OffsetX,
        self.Entity.Position[2] - self.OffsetY,
        self.Extent[1],
        self.Extent[2]
        )
end

function COMPONENT_QUAD:SetQuadColor(color)
    self.Color = color
end


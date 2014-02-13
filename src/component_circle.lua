require 'lcs.class'

COMPONENT_CIRCLE = class(function(o,parameters,entity)
    o.Radius = parameters.Radius
    o.Color = parameters.Color or {255,255,255,255}
    o.Layer = parameters.Layer or 1
    o.Segments = parameters.Segments or 16
    o.Entity = entity
end)

-- METHODS

function COMPONENT_CIRCLE:Update()
end

function COMPONENT_CIRCLE:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_CIRCLE:Render()
    love.graphics.setColor(self.Color)
    love.graphics.circle(
        "fill",
        self.Entity.Position[1],
        self.Entity.Position[2],
        self.Radius,
        self.Segments
        )
end

function COMPONENT_CIRCLE:SetCircleColor(color)
    self.Color = color
end


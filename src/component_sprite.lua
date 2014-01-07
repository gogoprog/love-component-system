require 'lcs.class'

COMPONENT_SPRITE = class(function(o,parameters,entity)
    o.Texture = parameters.Texture
    o.Extent = parameters.Extent
    o.Offset = parameters.Offset
    o.Entity = entity

    o.ScaleFactorX = o.Extent[1] / o.Texture:getWidth()
    o.ScaleFactorY = o.Extent[2] / o.Texture:getHeight()
end)

-- FUNCTIONS


-- METHODS

function COMPONENT_SPRITE:Update()
end

function COMPONENT_SPRITE:Render()
    love.graphics.draw(
        self.Texture,
        self.Entity.Position[1] - self.Extent[1] * 0.5,
        self.Entity.Position[2] - self.Extent[2] * 0.5,
        self.Entity.Orientation,
        self.ScaleFactorX,
        self.ScaleFactorY
        )
end


require 'lcs.class'

COMPONENT_SPRITE = class(function(o,parameters,entity)
    o.Texture = parameters.Texture
    o.Extent = parameters.Extent
    o.Offset = parameters.Offset
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.ScaleFactorX = o.Extent[1] / o.Texture:getWidth()
    o.ScaleFactorY = o.Extent[2] / o.Texture:getHeight()
    o.OffsetX = o.Texture:getWidth() * 0.5
    o.OffsetY = o.Texture:getHeight() * 0.5
end)

-- FUNCTIONS


-- METHODS

function COMPONENT_SPRITE:Update()
end

function COMPONENT_SPRITE:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_SPRITE:Render()
    love.graphics.draw(
        self.Texture,
        self.Entity.Position[1],
        self.Entity.Position[2],
        self.Entity.Orientation,
        self.ScaleFactorX,
        self.ScaleFactorY,
        self.OffsetX,
        self.OffsetY
        )
end

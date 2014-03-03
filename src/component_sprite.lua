require 'lcs.class'

COMPONENT_SPRITE = class(function(o,parameters,entity)
    o.Texture = parameters.Texture
    o.Quad = parameters.Quad
    o.Extent = parameters.Extent
    o.Offset = parameters.Offset
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.Color = parameters.Color or {255,255,255,255}

    local x,y,w,h

    if o.Quad then
        x,y,w,h = o.Quad:getViewport()
    else
        w = o.Texture:getWidth()
        h = o.Texture:getHeight()
    end

    if o.Extent == nil then
        o.Extent = {w,h}
    end

    o.ScaleFactorX = o.Extent[1] / w
    o.ScaleFactorY = o.Extent[2] / h
    o.OffsetX = w * 0.5
    o.OffsetY = h * 0.5

    o.World = parameters.World or 1

    o.Entity.Extent = o.Extent
end)

-- METHODS

function COMPONENT_SPRITE:Update()
end

function COMPONENT_SPRITE:PreRender()
    ENGINE.AddRenderable(self, self.Layer, self.World)
end

function COMPONENT_SPRITE:Render()
    local p = self.Entity.Position
    love.graphics.setColor(self.Color)
    
    if self.Quad then
        love.graphics.draw(
            self.Texture,
            self.Quad,
            p[1],
            p[2],
            self.Entity.Orientation,
            self.ScaleFactorX,
            self.ScaleFactorY,
            self.OffsetX,
            self.OffsetY
            )
    else
        love.graphics.draw(
            self.Texture,
            p[1],
            p[2],
            self.Entity.Orientation,
            self.ScaleFactorX,
            self.ScaleFactorY,
            self.OffsetX,
            self.OffsetY
            )
    end
end

function COMPONENT_SPRITE:SetColor(color)
    self.Color = color
end

function COMPONENT_SPRITE:SetSpriteTexture(texture)
    self.Texture = texture
end
require 'lcs.class'
require 'lcs.animation'

COMPONENT_ANIMATED_SPRITE = class(function(o,parameters,entity)
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.Extent = parameters.Extent or {cw, ch}
    o.Color = parameters.Color or {255,255,255,255}

    o:SetAnimation(parameters.Animation)
end)

-- METHODS

function COMPONENT_ANIMATED_SPRITE:Update(dt)
    self.Animation:Update(dt)
end

function COMPONENT_ANIMATED_SPRITE:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_ANIMATED_SPRITE:Render()
    local p = self.Entity.Position
    love.graphics.setColor(self.Color)
    self.Animation:Render(p[1],p[2],self.Entity.Orientation,self.ScaleFactorX,self.ScaleFactorY,self.OffsetX, self.OffsetY)
end

function COMPONENT_ANIMATED_SPRITE:SetAnimation(data)
    if self.Animation and self.Animation.Data == data then
        return
    end

    local anim = ANIMATION(data)
    self.Animations = { anim }
    self.Animation = anim

    local cw = data.CellWidth
    local ch = data.CellHeight
    self.OffsetX = cw * 0.5
    self.OffsetY = ch * 0.5
    self.Extent = self.Extent or {cw, ch}
    self.ScaleFactorX = self.Extent[1] / cw
    self.ScaleFactorY = self.Extent[2] / ch
end

function COMPONENT_ANIMATED_SPRITE:SetColor(color)
    self.Color = color
end
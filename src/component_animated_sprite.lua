require 'lcs.class'
require 'lcs.animation'

COMPONENT_ANIMATED_SPRITE = class(function(o,parameters,entity)
    local anim = ANIMATION(parameters.Animation)
    o.Animations = { anim }
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    local cw = parameters.Animation.CellWidth
    local ch = parameters.Animation.CellHeight
    o.OffsetX = cw * 0.5
    o.OffsetY = ch * 0.5
    o.Extent = parameters.Extent or {cw, ch}
    o.ScaleFactorX = o.Extent[1] / cw
    o.ScaleFactorY = o.Extent[2] / ch
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
    self.Animation:Render(p[1],p[2],self.Entity.Orientation,self.ScaleFactorX,self.ScaleFactorY,self.OffsetX, self.OffsetY)
end

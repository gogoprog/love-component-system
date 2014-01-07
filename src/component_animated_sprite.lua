require 'lcs.class'
require 'lcs.animation'

COMPONENT_ANIMATED_SPRITE = class(function(o,parameters,entity)
    o.Animation = ANIMATION(parameters.Animation)
    o.Entity = entity
    o.OffsetX = parameters.Animation.Parameters.CellWidth * 0.5
    o.OffsetY = parameters.Animation.Parameters.CellHeight * 0.5
end)

-- METHODS

function COMPONENT_ANIMATED_SPRITE:Update(dt)
    self.Animation:Update(dt)
end

function COMPONENT_ANIMATED_SPRITE:Render()
    local p = self.Entity.Position
    self.Animation:Render(p[1],p[2],self.Entity.Orientation,self.OffsetX, self.OffsetY)
end

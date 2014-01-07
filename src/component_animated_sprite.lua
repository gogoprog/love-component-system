require 'lcs.class'
require 'lcs.component_sprite'
require 'lcs.animation'

COMPONENT_ANIMATED_SPRITE = class(function(o,parameters,entity)
    o.Animation = ANIMATION(parameters.Animation)
    o.Entity = entity
end)

-- METHODS

function COMPONENT_ANIMATED_SPRITE:Update(dt)
    self.Animation:Update(dt)
end

function COMPONENT_ANIMATED_SPRITE:Render()
    local p = self.Entity.Position
    self.Animation:Render(p[1],p[2])
end

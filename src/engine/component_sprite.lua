require 'engine.class'

COMPONENT_SPRITE = class(function(o,parameters,entity)
    o.Texture = parameters.Texture
    o.Extent = parameters.Extent
    o.Offset = parameters.Offset
    o.Entity = entity
end)

-- FUNCTIONS


-- METHODS

function COMPONENT_SPRITE:Update()
end

function COMPONENT_SPRITE:Render()
    love.graphics.draw(
        self.Texture,
        self.Entity.Position[1],
        self.Entity.Position[2],
        self.Entity.Orientation
        )
end


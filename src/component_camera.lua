require 'lcs.class'

COMPONENT_CAMERA = class(function(o,parameters,entity)
    o.Entity = entity
    o.Extent = parameters.Extent
end)

-- METHODS

function COMPONENT_CAMERA:Update(dt)
end

function COMPONENT_CAMERA:PreRender()
    local e = self.Extent
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.origin()

    ---love.graphics.scale(w / e[1], h / e[2])

    local p = self.Entity.Position
    love.graphics.translate(-p[1],-p[2])
end

function COMPONENT_CAMERA:Render()

end

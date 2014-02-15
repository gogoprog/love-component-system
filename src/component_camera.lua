require 'lcs.class'

COMPONENT_CAMERA = class(function(o,parameters,entity)
    o.Entity = entity
    o.Extent = parameters.Extent
    o.World = parameters.World or 1

    ENGINE.SetCamera(o.World, o)
end)

-- METHODS

function COMPONENT_CAMERA:Update(dt)
end

function COMPONENT_CAMERA:PreRender()

end

function COMPONENT_CAMERA:Apply()
    local e = self.Extent
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    love.graphics.origin()

    ---love.graphics.scale(w / e[1], h / e[2])

    local p = self.Entity.Position
    love.graphics.translate(-p[1],-p[2])
end


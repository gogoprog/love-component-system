require 'lcs.class'

COMPONENT_BOUNDING = class(function(o,parameters,entity)
    o.Entity = entity
    parameters.World = parameters.World or COMPONENT_BOUNDING_WORLD.DefaultWorld
    o.World = parameters.World

    local p = entity.Position
    local e = parameters.Extent

    o.OffsetX = e[1] * 0.5
    o.OffsetY = e[2] * 0.5

    o.Quad = love.graphics.newQuad(p[1]-o.OffsetX, p[2]-o.OffsetY, e[1], e[2], 1, 1)

    o.World:Add(o.Quad)
end)

-- METHODS

function COMPONENT_BOUNDING:Unregister(dt)
    self.World:Remove(self.Quad)
end

function COMPONENT_BOUNDING:Update(dt)
    local x,y,w,h = self.Quad:getViewport()
    local p = self.Entity.Position
    self.Quad:setViewport(p[1]-self.OffsetX,p[2]-self.OffsetY,w,h)
end

function COMPONENT_BOUNDING:PreRender()

end

function COMPONENT_BOUNDING:Collides()
    self:Update()
    return self.World:Collides(self.Quad)
end
require 'lcs.class'

COMPONENT_BOUNDING_WORLD = class(function(o,parameters,entity)
    o.Quads = {}
    COMPONENT_BOUNDING_WORLD.DefaultWorld = COMPONENT_BOUNDING_WORLD.DefaultWorld or o
end)

-- METHODS

function COMPONENT_BOUNDING_WORLD:Update(dt)

end

function COMPONENT_BOUNDING_WORLD:PreRender()

end

function COMPONENT_BOUNDING_WORLD:Collides(quad)
    local qx,qy,qw,qh = quad:getViewport()
    for k,v in ipairs(self.Quads) do
        if v ~= quad then
            local x,y,w,h = v:getViewport()

            if not( qx > x + w or qx + qw < x or qy > y + h or qy + qh < y ) then
                return true
            end
        end
    end

    return false
end

function COMPONENT_BOUNDING_WORLD:Add(quad)
    table.insert(self.Quads,quad)
end

function COMPONENT_BOUNDING_WORLD:Remove(quad)
    table.remove(self.Quads,quad)
end
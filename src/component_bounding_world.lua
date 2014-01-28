require 'lcs.class'

COMPONENT_BOUNDING_WORLD = class(function(o,parameters,entity)
    o.Boundings = {}
    COMPONENT_BOUNDING_WORLD.DefaultWorld = COMPONENT_BOUNDING_WORLD.DefaultWorld or o
end)

-- METHODS

function COMPONENT_BOUNDING_WORLD:Update(dt)

end

function COMPONENT_BOUNDING_WORLD:PreRender()

end

function COMPONENT_BOUNDING_WORLD:CollidesWithBounding(bounding)
    local qx,qy,qw,qh = bounding.Quad:getViewport()
    for k,v in ipairs(self.Boundings) do
        if v ~= bounding then
            if v:Collides(qx,qy,qw,qh) then
                return true
            end
        end
    end

    return false
end

function COMPONENT_BOUNDING_WORLD:Collides(qx,qy,qw,qh)

    for k,v in ipairs(self.Boundings) do
        if v:Collides(qx,qy,qw,qh) then
            return true
        end
    end

    return false
end

function COMPONENT_BOUNDING_WORLD:Unregister()
    if COMPONENT_BOUNDING_WORLD.DefaultWorld == self then
        COMPONENT_BOUNDING_WORLD.DefaultWorld = nil
    end
end

function COMPONENT_BOUNDING_WORLD:Add(bounding)
    table.insert(self.Boundings,bounding)
end

function COMPONENT_BOUNDING_WORLD:Remove(bounding)
    for k,b in ipairs(self.Boundings) do
        if b == bounding then
            self.Boundings[k] = self.Boundings[#self.Boundings]
        end
    end
    table.remove(self.Boundings,#self.Boundings)
end


function COMPONENT_BOUNDING_WORLD:Intersects(x1,y1,x2,y2)

    for k,b in ipairs(self.Bounding) do
        if b:Intersects(x1,y1,x2,y2) then
            return true
        end
    end

    return false
end
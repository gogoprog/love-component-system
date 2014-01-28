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

    o.World:Add(o)
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

function COMPONENT_BOUNDING:CollidesWithWorld()
    self:Update()
    return self.World:CollidesWithBounding(self)
end

local function BoxSegmentIntersection(l,t,w,h, x1,y1,x2,y2)
  local dx, dy  = x2-x1, y2-y1

  local t0, t1  = 0, 1
  local p, q, r

  for side = 1,4 do
    if     side == 1 then p,q = -dx, x1 - l
    elseif side == 2 then p,q =  dx, l + w - x1
    elseif side == 3 then p,q = -dy, y1 - t
    else                  p,q =  dy, t + h - y1
    end

    if p == 0 then
      if q < 0 then return nil end
    else
      r = q / p
      if p < 0 then
        if     r > t1 then return nil
        elseif r > t0 then t0 = r
        end
      else
        if     r < t0 then return nil
        elseif r < t1 then t1 = r
        end
      end
    end
  end

  local ix1, iy1, ix2, iy2 = x1 + t0 * dx, y1 + t0 * dy,
                             x1 + t1 * dx, y1 + t1 * dy

  if ix1 == ix2 and iy1 == iy2 then return ix1, iy1 end
  return ix1, iy1, ix2, iy2
end


function COMPONENT_BOUNDING:Intersects(x1,y1,x2,y2)
    local l,t,w,h = self.Quad:getViewport()

    return BoxSegmentIntersection(l,t,w,h,x1,y1,x2,y2) ~= nil
end


function COMPONENT_BOUNDING:Collides(qx,qy,qw,qh)
    local x,y,w,h = self.Quad:getViewport()

    if not( qx > x + w or qx + qw < x or qy > y + h or qy + qh < y ) then
        return true
    end

    return false
end
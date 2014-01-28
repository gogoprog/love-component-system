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
    --qx = math.floor(qx)
    --qy = math.floor(qy)

    for k,v in ipairs(self.Quads) do
        if v ~= quad then
            local x,y,w,h = v:getViewport()
            --x = math.floor(x)
            --y = math.floor(y)
            if not( qx > x + w or qx + qw < x or qy > y + h or qy + qh < y ) then
                return true
            end
        end
    end

    return false
end

function COMPONENT_BOUNDING_WORLD:Collides2(qx,qy,qw,qh)
    --qx = math.floor(qx)
    --qy = math.floor(qy)

    for k,v in ipairs(self.Quads) do
        if v ~= quad then
            local x,y,w,h = v:getViewport()
            --x = math.floor(x)
            --y = math.floor(y)
            if not( qx > x + w or qx + qw < x or qy > y + h or qy + qh < y ) then
                return true
            end
        end
    end

    return false
end

function COMPONENT_BOUNDING_WORLD:Unregister()
    if COMPONENT_BOUNDING_WORLD.DefaultWorld == self then
        COMPONENT_BOUNDING_WORLD.DefaultWorld = nil
    end
end

function COMPONENT_BOUNDING_WORLD:Add(quad)
    table.insert(self.Quads,quad)
end

function COMPONENT_BOUNDING_WORLD:Remove(quad)
    for k,q in ipairs(self.Quads) do
        if q == quad then
            self.Quads[k] = self.Quads[#self.Quads]
        end
    end
    table.remove(self.Quads,#self.Quads)
end


function boxSegmentIntersection(l,t,w,h, x1,y1,x2,y2)
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
      if q < 0 then return nil end  -- Segment is parallel and outside the bbox
    else
      r = q / p
      if p < 0 then
        if     r > t1 then return nil
        elseif r > t0 then t0 = r
        end
      else -- p > 0
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


function COMPONENT_BOUNDING_WORLD:Intersects(x1,y1,x2,y2)

    for k,q in ipairs(self.Quads) do
        local l,t,w,h = q:getViewport()
        
        if boxSegmentIntersection(l,t,w,h,x1,y1,x2,y2) ~= nil then
            return true
        end
    end

    return false
end
require 'lcs.class'

COMPONENT_CANNON= class(function(o,parameters,entity)
    o.Entity = entity
end)

-- METHODS

function COMPONENT_CANNON:Update(dt)
    local p = self.Entity.Position
    local mp = GAME.Instance.MouseWorldPosition
    local deltap = {mp[1]-p[1], mp[2]-p[2]}

    local angle = math.atan2(deltap[1],deltap[2])

    self.Entity.Orientation = -angle
end

function COMPONENT_CANNON:PreRender()

end

function COMPONENT_CANNON:Render()
end

function COMPONENT_CANNON:Shoot()
    local p = self.Entity.Position
    GAME.Instance:SpawnBall({p[2],p[1]})
end


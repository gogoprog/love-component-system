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
    local ball = GAME.Instance:SpawnBall({p[1],p[2]})

    local o = self.Entity.Orientation
    local x,y = -math.sin(o), math.cos(o)

    ball:ApplyLinearImpulse(x*150000,y*150000)
end


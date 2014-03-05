require 'lcs.class'

local FIXED_RATE = 0.01

COMPONENT_PHYSIC_WORLD = class(function(o,parameters,entity)
    local gravity = parameters.Gravity or { 0, 9.81 * 64 }
    o.World = love.physics.newWorld(gravity[1], gravity[2], true)
    o.World:setCallbacks(COMPONENT_PHYSIC_WORLD.CollisionBegin,COMPONENT_PHYSIC_WORLD.CollisionEnd,nil,COMPONENT_PHYSIC_WORLD.CollisionPostSolve)
    o.TimeSum = 0
    o.Entity = entity
    COMPONENT_PHYSIC_WORLD.DefaultWorld = COMPONENT_PHYSIC_WORLD.DefaultWorld or o
end)

-- FUNCTIONS

function COMPONENT_PHYSIC_WORLD.CollisionBegin(a, b)
    local user_data_a, user_data_b = a:getUserData(), b:getUserData()

    if user_data_a and user_data_b then
        user_data_a:OnCollisionBegin(user_data_b)
        user_data_b:OnCollisionBegin(user_data_a)
    end
end

function COMPONENT_PHYSIC_WORLD.CollisionEnd(a, b)
    local user_data_a, user_data_b = a:getUserData(), b:getUserData()

    if user_data_a and user_data_b then
        user_data_a:OnCollisionEnd(user_data_b)
        user_data_b:OnCollisionEnd(user_data_a)
    end
end

function COMPONENT_PHYSIC_WORLD.CollisionPostSolve(a, b, c, impulseA, impulseB)
    local user_data_a, user_data_b = a:getUserData(), b:getUserData()

    if user_data_a and user_data_b then
        user_data_a:OnCollisionPostSolve(user_data_b, impulseA, impulseB)
        user_data_b:OnCollisionPostSolve(user_data_a, impulseB, impulseA)
    end
end

function COMPONENT_PHYSIC_WORLD.RayCastFirst(fixture, x, y, xn, yn, fraction)
    COMPONENT_PHYSIC_WORLD.Result = fixture:getUserData()
    return 0
end

function COMPONENT_PHYSIC_WORLD.RayCast(fixture, x, y, xn, yn, fraction)
    table.insert(COMPONENT_PHYSIC_WORLD.Result,fixture:getUserData())
    return 1
end

-- METHODS

function COMPONENT_PHYSIC_WORLD:Unregister()
    if COMPONENT_PHYSIC_WORLD.DefaultWorld == self then
        COMPONENT_PHYSIC_WORLD.DefaultWorld = nil
    end
    self.World:destroy()
end

function COMPONENT_PHYSIC_WORLD:Update(dt)
    self.TimeSum = self.TimeSum + dt

    while self.TimeSum >= FIXED_RATE do
        self.World:update(FIXED_RATE)
        self.TimeSum = self.TimeSum - FIXED_RATE
    end
end

function COMPONENT_PHYSIC_WORLD:PreRender()

end

function COMPONENT_PHYSIC_WORLD:RayTestFirst(x1,y1,x2,y2)
    COMPONENT_PHYSIC_WORLD.Result = nil
    self.World:rayCast(x1,y1,x2,y2, COMPONENT_PHYSIC_WORLD.RayCastFirst)
    return COMPONENT_PHYSIC_WORLD.Result
end

function COMPONENT_PHYSIC_WORLD:RayTest(x1,y1,x2,y2)
    COMPONENT_PHYSIC_WORLD.Result = {}
    self.World:rayCast(x1,y1,x2,y2, COMPONENT_PHYSIC_WORLD.RayCast)
    return COMPONENT_PHYSIC_WORLD.Result
end
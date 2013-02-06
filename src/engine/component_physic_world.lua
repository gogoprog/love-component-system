require 'engine.class'

COMPONENT_PHYSIC_WORLD = class(function(o,parameters,entity)
    local gravity = parameters.Gravity or { 0, 9.81 * 64 }
    o.World = love.physics.newWorld(gravity[1], gravity[2], true)
    o.World:setCallbacks(COMPONENT_PHYSIC_WORLD.CollisionStart)
    o.Entity = entity
    o.Entity.World = o.World
end)

-- FUNCTIONS

function COMPONENT_PHYSIC_WORLD.CollisionStart(a, b)
    local user_data_a, user_data_b = a:getUserData(), b:getUserData()

    if user_data_a and user_data_b then
        user_data_a:HandleEvent("CollisionStart", {other = user_data_b})
        user_data_b:HandleEvent("CollisionStart", {other = user_data_a})
    end
end

-- METHODS

function COMPONENT_PHYSIC_WORLD:Update(dt)
    self.World:update(dt)
end

function COMPONENT_PHYSIC_WORLD:Render()

end
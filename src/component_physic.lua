require 'lcs.class'

local COMPONENT_PHYSIC_Init = {
    circle = function(o,parameters,x,y,typ)
        o.Body = love.physics.newBody(parameters.World.World, x, y, typ or "dynamic")
        o.Shape = love.physics.newCircleShape(parameters.Radius)
    end,
    rectangle = function(o,parameters,x,y,typ)
        o.Body = love.physics.newBody(parameters.World.World, x, y, typ or "dynamic")
        o.Shape = love.physics.newRectangleShape(parameters.Extent[1], parameters.Extent[2])
    end
}

COMPONENT_PHYSIC = class(function(o,parameters,entity)
    parameters.Type = parameters.Type or "dynamic"
    parameters.World = parameters.World or COMPONENT_PHYSIC_WORLD.DefaultWorld
    COMPONENT_PHYSIC_Init[parameters.Shape](o,parameters,entity.Position[1],entity.Position[2],parameters.Type)

    o.Fixture = love.physics.newFixture(o.Body, o.Shape, parameters.Density)
    o.Fixture:setUserData(entity)

    o.Type = parameters.Type
    o.Entity = entity
    o.World = parameters.World
end)

-- METHODS

function COMPONENT_PHYSIC:Unregister()
    if self.World.Entity.ItIsRegistered then
        self.Fixture:destroy()
        self.Body:destroy()
    end
end

function COMPONENT_PHYSIC:Update(dt)
    local position = self.Entity.Position

    if self.Type == "dynamic" then
        position[1] = self.Body:getX()
        position[2] = self.Body:getY()
        self.Entity.Orientation = self.Body:getAngle()
    else
        self.Body:setPosition(position[1],position[2])
        self.Body:setAngle(self.Entity.Orientation)
    end
end

function COMPONENT_PHYSIC:PreRender()

end

function COMPONENT_PHYSIC:ApplyForce(x,y)
    self.Body:applyForce(x,y)
end

function COMPONENT_PHYSIC:ApplyLinearImpulse(x,y)
    self.Body:applyLinearImpulse(x,y)
end

function COMPONENT_PHYSIC:SetPosition(t)
    self.Body:setPosition(t[1],t[2])
end

function COMPONENT_PHYSIC:SetOrientation(r)
    self.Body:setAngle(r)
end

function COMPONENT_PHYSIC:SetLinearVelocity(x,y)
    self.Body:setLinearVelocity(x,y)
end

function COMPONENT_PHYSIC:GetLinearVelocity()
    return self.Body:getLinearVelocity()
end

function COMPONENT_PHYSIC:GetFixture()
    return self.Fixture
end
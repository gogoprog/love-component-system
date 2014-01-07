require 'lcs.class'

local COMPONENT_PHYSIC_Init = {
    circle = function(o,parameters,x,y)
        o.Body = love.physics.newBody(parameters.World, x, y, "dynamic")
        o.Shape = love.physics.newCircleShape(parameters.Radius)
    end,
    rectangle = function(o,parameters,x,y)
        o.Body = love.physics.newBody(parameters.World, x, y )
        o.Shape = love.physics.newRectangleShape(parameters.Extent[1], parameters.Extent[2])
    end
}

COMPONENT_PHYSIC = class(function(o,parameters,entity)
    COMPONENT_PHYSIC_Init[parameters.Shape](o,parameters,entity.Position[1],entity.Position[2])
    o.Fixture = love.physics.newFixture(o.Body, o.Shape)
    o.Fixture:setUserData(entity)
    o.Dynamic = parameters.Dynamic
    o.Entity = entity
end)

-- METHODS

function COMPONENT_PHYSIC:Update(dt)
    local position = self.Entity.Position

    if self.Dynamic == true then
        position[1] = self.Body:getX()
        position[2] = self.Body:getY()
        self.Entity.Orientation = self.Body:getAngle()
    else
        self.Body:setPosition(position[1],position[2])
        self.Body:setAngle(self.Entity.Orientation)
    end
end

function COMPONENT_PHYSIC:Render()

end

function COMPONENT_PHYSIC:ApplyForce(x,y)
    self.Body:applyForce(x,y)
end

function COMPONENT_PHYSIC:ApplyLinearImpulse(x,y)
    self.Body:applyLinearImpulse(x,y)
end

function COMPONENT_PHYSIC:SetPosition(x,y)
    self.Body:setPosition(x,y)
end
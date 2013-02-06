require 'engine.entity'
require 'engine.component_physic_world'
require 'engine.component_physic'
require 'engine.component_sprite'
require 'engine.component_quad'

-- Locals

WorldDescription = {
    PHYSIC_WORLD = {
    }
}

local world = ENTITY(WorldDescription)

ObjectDescription = {
    SPRITE = {
        Texture = love.graphics.newImage("data/texture.png"),
        Extent = {64,64}
    },
    PHYSIC = {
        World = world.World,
        Shape = "circle",
        Radius = 64,
        Dynamic = true
    }
}

GroundDescription = {
    SPRITE = {
        Texture = love.graphics.newImage("data/texture.png"),
        Extent = {128,128}
    },
    QUAD = {
        Extent = {1024,60}
    },
    PHYSIC = {
        World = world.World,
        Shape = "rectangle",
        Extent = {1024,60},
        Dynamic = false
    }
}

HEART = entity_class(function(o,d)
    o.Value = 10
    o:SetPosition(256, 0)
end)

function HEART:OnCollisionStart()
    self:ApplyForce(1000, 0)
end

local heart = HEART(ObjectDescription)
local ground = ENTITY(GroundDescription)

-- Callbacks

function love.load()
    love.physics.setMeter(32)
    ground.Position[2] = 400
end

function love.update(dt)
    ENTITY.UpdateAll(dt)
end

function love.draw()
    ENTITY.RenderAll()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
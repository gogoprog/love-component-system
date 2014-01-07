require 'lcs.entity'
require 'lcs.component_physic_world'
require 'lcs.component_physic'
require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_camera'
require 'lcs.camera'

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
        Radius = 32,
        Dynamic = true
    }
}

GroundDescription = {
    QUAD = {
        Extent = {300,60}
    },
    PHYSIC = {
        World = world.World,
        Shape = "rectangle",
        Extent = {300,60},
        Dynamic = false
    }
}

HEART = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
    o.Value = 10
end)

function HEART:OnCollisionStart()
    self:ApplyLinearImpulse(0, -1000)
end

GROUND = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
end)

function GROUND:OnCollisionStart()
end

local heart = HEART(ObjectDescription,{0,-200})
local ground = GROUND(GroundDescription, {0,200})

local camera = CAMERA({-400,-300})

-- Callbacks

function love.load()
    love.physics.setMeter(32)
end

function love.update(dt)
    ENTITY.UpdateAll(dt)
end

function love.draw()
    camera:PreRender()
    ENTITY.RenderAll()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    elseif key == "left" then
        heart:ApplyLinearImpulse(-100,0)
    elseif key == "right" then
        heart:ApplyLinearImpulse(100,0)
    end
end
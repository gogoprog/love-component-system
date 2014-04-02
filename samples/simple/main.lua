require 'lcs.engine'

-- Locals

local texture = love.graphics.newImage("data/texture.png")
local descriptions ={
    World = {
        {
            Type = "PHYSIC_WORLD",
            Properties = {}
        }
    },
    Object = {
    {
        Type = "SPRITE",
        Properties = {
            Texture = texture,
            Extent = {64,64},
            Layer = 3
        }
        },
    {
        Type = "PHYSIC",
        Properties = {
            Shape = "circle",
            Radius = 32
        }
    },
    {
        Type = "PARTICLE",
        Properties = {
            Layer = 2
        }
    }
    },
    Ground = {
        {
            Type = "QUAD",
            Properties = {
                Extent = {600,60},
                Layer = 1
            }
        },
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "rectangle",
                Extent = {600,60},
                Type = "static"
            }
        }
    },
    Camera = {
        {
            Type = "CAMERA",
            Properties = {}
        }
    }
}

-- Entity classes

HEART = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
end)

function HEART:OnCollisionBegin()
    self:ApplyLinearImpulse(0, -3000)
end

GROUND = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
end)

-- Callbacks

local heart1, heart2

function love.load(arg)
    ENGINE.Initialize(arg)

    local ps = love.graphics.newParticleSystem(texture, 30)
    ps:setEmissionRate(30)
    ps:setParticleLifetime(2)
    ps:setSizes(1,5)
    ps:setColors(255,255,255,255,0,0,0,0)

    local ps2 = love.graphics.newParticleSystem(texture, 30)
    ps2:setEmissionRate(30)
    ps2:setParticleLifetime(2)
    ps2:setSizes(1,5)
    ps2:setColors(255,255,255,255,0,0,0,0)

    ENTITY(descriptions.World)
    GROUND(descriptions.Ground, {0,300})
    ENTITY(descriptions.Camera,{-400,-300})

    heart1 = HEART(descriptions.Object,{-200,-200})
    heart2 = HEART(descriptions.Object,{200,-200})

    heart1:AddParticleSystem(ps,false)
    heart2:AddParticleSystem(ps2,true)
end

function love.update(dt)
    ENGINE.Update(dt)
end

function love.draw()
    ENGINE.Render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    elseif key == "left" then
        heart1:ApplyLinearImpulse(-100,0)
    elseif key == "right" then
        heart1:ApplyLinearImpulse(100,0)
    elseif key == "r" then
        heart1:SetOrientation(heart1.Orientation + 10)
    end
end
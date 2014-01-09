require 'lcs.engine'

-- Locals

local descriptions ={
    World = {
        PHYSIC_WORLD = {
        }
    },
    Object = {
        SPRITE = {
            Texture = love.graphics.newImage("data/texture.png"),
            Extent = {64,64}
        },
        PHYSIC = {
            Shape = "circle",
            Radius = 32,
            Dynamic = true
        }
    },
    Ground = {
        QUAD = {
            Extent = {300,60}
        },
        PHYSIC = {
            Shape = "rectangle",
            Extent = {300,60},
            Dynamic = false
        }
    },
    Camera = {
        CAMERA = {
        }
    }
}

-- Entity classes

HEART = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
end)

function HEART:OnCollisionStart()
    self:ApplyLinearImpulse(0, -3000)
end

GROUND = entity_class(function(o,d,p)
    ENTITY.Init(o,d,p)
end)

function GROUND:OnCollisionStart()
end

-- Callbacks

local heart

function love.load()
    ENTITY(descriptions.World)
    heart = HEART(descriptions.Object,{0,-200})
    GROUND(descriptions.Ground, {0,200})
    ENTITY(descriptions.Camera,{-400,-300})
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
        heart:ApplyLinearImpulse(-100,0)
    elseif key == "right" then
        heart:ApplyLinearImpulse(100,0)
    end
end
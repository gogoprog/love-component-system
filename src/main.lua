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
        Extent = {128,128}
    },
    PHYSIC = {
        World = world.World,
        Shape = "circle",
        Radius = 32,
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

local test = ENTITY(ObjectDescription)
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
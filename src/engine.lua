require "lcs.entity"

require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_circle'
require 'lcs.component_animated_sprite'
require 'lcs.component_physic'
require 'lcs.component_physic_world'
require 'lcs.component_camera'
require 'lcs.component_text'
require 'lcs.component_particle'
require 'lcs.component_sprite_batch'
require 'lcs.component_static_sprite'
require 'lcs.component_bounding'
require 'lcs.component_bounding_world'
require 'lcs.component_lifetime'

require 'lcs.state_machine'

require 'lcs.texture'
require 'lcs.animation'
require 'lcs.sprite_sheet'

ENGINE = {
    RenderWorlds = {},
    Cameras = {}
}

function ENGINE.Initialize(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
end

function ENGINE.Update(dt)
    ENTITY.UpdateAll(dt)
end

function ENGINE.Render()
    ENGINE.RenderWorlds = {}

    ENTITY.PreRenderAll()

    for k,w in pairs(ENGINE.RenderWorlds) do
        if ENGINE.Cameras[k] then
            ENGINE.Cameras[k]:Apply()
        end

        local a = {}
        for n in pairs(w) do table.insert(a, n) end
        table.sort(a)

        for i,n in ipairs(a) do
            for _,item in ipairs(w[n]) do
                item:Render()
            end
        end
    end
end

function ENGINE.AddRenderable(item, layer, world)
    world = world or 1
    if not ENGINE.RenderWorlds[world] then
        ENGINE.RenderWorlds[world] = {}
    end

    if not ENGINE.RenderWorlds[world][layer] then
        ENGINE.RenderWorlds[world][layer] = {}
    end

    table.insert(ENGINE.RenderWorlds[world][layer], item)
end

function ENGINE.DebugDraw()
    love.graphics.setColor({0,0,0,128})
    love.graphics.rectangle("fill", 0, 20, 128, 20 )
    love.graphics.print("Entities: " .. #ENTITY.Items, 10, 20)
    love.graphics.setColor({255,255,255,255})

    love.graphics.print("Entities: " .. #ENTITY.Items, 11, 21)
    love.graphics.setColor({255,255,255,255})
end

function ENGINE.SetCamera(w, camera)
    ENGINE.Cameras[w] = camera
end
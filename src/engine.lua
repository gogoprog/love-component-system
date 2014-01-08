require "lcs.entity"

require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_animated_sprite'
require 'lcs.component_camera'
require 'lcs.component_physic'
require 'lcs.component_physic_world'

ENGINE = {
    Renderables = {}
}

function ENGINE.Update(dt)
    ENTITY.UpdateAll(dt)
end

function ENGINE.Render()
    for k,v in pairs(ENGINE.Renderables) do
        v = {}
    end

    ENTITY.PreRenderAll()

    for k,v in pairs(ENGINE.Renderables) do
        for _,item in ipairs(v) do
            item:Render()
        end
    end
end

function ENGINE.AddRenderable(item, layer)
    ENGINE.Renderables[layer] = ENGINE.Renderables[layer] or {}
    table.insert(ENGINE.Renderables[layer], item)
end
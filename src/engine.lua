require "lcs.entity"

require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_animated_sprite'
require 'lcs.component_physic'
require 'lcs.component_physic_world'

require 'lcs.camera'
require 'lcs.animation'

ENGINE = {
    Renderables = {}
}

function ENGINE.Update(dt)
    ENTITY.UpdateAll(dt)
end

function ENGINE.Render()
    for l=1,100 do
        ENGINE.Renderables[l] = {}
    end

    ENTITY.PreRenderAll()

    for k,v in pairs(ENGINE.Renderables) do
        for _,item in ipairs(v) do
            item:Render()
        end
    end
end

function ENGINE.AddRenderable(item, layer)
    table.insert(ENGINE.Renderables[layer], item)
end
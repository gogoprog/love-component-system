require "lcs.entity"

require 'lcs.component_sprite'
require 'lcs.component_quad'
require 'lcs.component_animated_sprite'
require 'lcs.component_physic'
require 'lcs.component_physic_world'
require 'lcs.component_camera'
require 'lcs.component_text'
require 'lcs.component_particle'
require 'lcs.component_sprite_batch'
require 'lcs.component_static_sprite'

require 'lcs.animation'
require 'lcs.sprite_sheet'

ENGINE = {
    Renderables = {}
}

function ENGINE.Initialize(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end
end

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
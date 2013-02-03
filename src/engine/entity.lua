require 'engine.class'

ENTITY = class(function(o,components)
    o.Components = {}
    for k,v in pairs(components) do
        table.insert(o.Components,_G["COMPONENT_" .. k](v,o))
    end
    o.Position = { 0, 0, 0 }
    o.Orientation = 0

    table.insert(ENTITY.Items,o)
end)

ENTITY.Items = {}
ENTITY.ItemsToDestroy = {}

-- FUNCTIONS

function ENTITY.UpdateAll(dt)
    for k,v in ipairs(ENTITY.Items) do
        v:Update(dt)
    end

    for k,v in ipairs(ENTITY.ItemsToDestroy) do
        -- :TODO: Unload ...
        table.remove(ENTITY.Items,v)
    end
end

function ENTITY.RenderAll()
    for k,v in ipairs(ENTITY.Items) do
        v:Render()
    end
end

-- METHODS

function ENTITY:Update(dt)
    for k,v in ipairs(self.Components) do
        v:Update(dt)
    end
end

function ENTITY:Render()
    for k,v in ipairs(self.Components) do
        v:Render()
    end
end

function ENTITY:Destroy()
    table.remove(ENTITY.ItemsToDestroy,self)
end

function ENTITY:HandleMessage(message_id, parameters)
    local string = "On" .. message_id

    if self[string] ~= nil then
        self[string](self, parameters)
    end

    print(string)
end
local EntityMethoder = {}
local EntityMethoder_mt = {
    __call = function(o, e, ...)
        return EntityMethoder.Function(EntityMethoder.Component, ...)
    end
}
setmetatable(EntityMethoder,EntityMethoder_mt)

function entity_class(base, init, no_parent)
    local c = {}

    if not init and type(base) == 'function' then
        init = base
        base = nil
    elseif type(base) == 'table' then
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end

    if not no_parent and not base then
        base = ENTITY
        for i,v in pairs(base) do
            c[i] = v
        end
        c._base = base
    end

    c.__index = function(t,key)
        if c[key] == nil then
            for k,v in ipairs(t.Components) do
                if v[key] ~= nil then
                    EntityMethoder.Function = v[key]
                    EntityMethoder.Component = v
                    return EntityMethoder
                end
            end
            return function() end
        end

        return c[key]
    end

    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj,c)

        if init then
            init(obj,...)
        end
        return obj
    end

    c.Init = init
    c.IsA = function(self, klass)
        local m = getmetatable(self)
        while m do 
            if m == klass then return true end
            m = m._base
        end
        return false
    end

    setmetatable(c, mt)
    return c
end

ENTITY = entity_class(function(o,components,position)

    o.Orientation = 0
    o.Position = position or { 0, 0, 0 }

    o.Components = {}
    if components ~= nil then
        local component, properties, constructor
        for k,v in pairs(components) do

            if type(k) == 'string' then
                constructor = _G["COMPONENT_" .. k]
                properties = v
            else
                constructor = _G["COMPONENT_" .. v.Type]
                properties = v.Properties
            end

            if constructor.new then
                component = constructor:new(properties,o)
            else
                component = constructor(properties,o)
            end

            if component.Initialize then
                component:Initialize()
            end

            if component.Register then
                component:Register()
            end

            table.insert(o.Components, component)
        end
    end
    table.insert(ENTITY.Items,o)
end,
nil,
true)

ENTITY.Items = ENTITY.Items or {}
ENTITY.ItemsToDestroy = ENTITY.ItemsToDestroy or {}

-- FUNCTIONS

function ENTITY.DestroyAll()
    for k,v in ipairs(ENTITY.Items) do
        v:Unregister()
    end

    ENTITY.Items = {}
end

function ENTITY.UpdateAll(dt)
    for k,v in ipairs(ENTITY.Items) do
        v:InternalUpdate(dt)
    end

    for k,v in ipairs(ENTITY.ItemsToDestroy) do
        v:Unregister()
        v.Components = {}
        for j,item in ipairs(ENTITY.Items) do
            if item == v then
                ENTITY.Items[j] = ENTITY.Items[#ENTITY.Items]
                ENTITY.Items[#ENTITY.Items] = nil
                break
            end
        end
    end

    ENTITY.ItemsToDestroy = {}
end

function ENTITY.PreRenderAll()
    for k,v in ipairs(ENTITY.Items) do
        v:PreRender()
    end
end

function ENTITY.GetCount()
    return #ENTITY.Items
end

function ENTITY.GetItems()
    return ENTITY.Items
end

-- METHODS

function ENTITY:Register()
    for k,v in ipairs(self.Components) do
        if v.Register then
            v:Register()
        end
    end
end

function ENTITY:Unregister()
    for k,v in ipairs(self.Components) do
        if v.Unregister then
            v:Unregister()
        end
    end
end

function ENTITY:InternalUpdate(dt)
    self:Update(dt)
    for k,v in ipairs(self.Components) do
        v:Update(dt)
    end
end

function ENTITY:UpdateComponents(dt)
    for k,v in ipairs(self.Components) do
        v:Update(dt)
    end
end

function ENTITY:Update(dt)
end

function ENTITY:Render()
    for k,v in ipairs(self.Components) do
        v:Render()
    end
end

function ENTITY:Destroy()
    table.insert(ENTITY.ItemsToDestroy,self)
    self.ItIsDestroyed = true
end

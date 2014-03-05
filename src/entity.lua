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

    c.__newindex = function(t,key,value)
        local fn = "Set" .. key
        local cs = rawget(t,"Components")
        if cs then
            for k,v in ipairs(cs) do
                if v[fn] then
                    v[fn](v,value)
                    return
                end
            end
        end
        rawset(t,key,value)
    end

    c.__index = function(t,key)
        if key == "Position" then
            return rawget(t,"_Position")
        end

        if key == "Orientation" then
            return rawget(t,"_Orientation")
        end

        if c[key] == nil then
            for k,v in ipairs(rawget(t,"Components")) do
                if v[key] ~= nil then
                    EntityMethoder.Function = v[key]
                    EntityMethoder.Component = v
                    return EntityMethoder
                end
            end

            if string.sub(key,1,2) == "On" then
                return function() end
            end

            return nil
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
    o._Position = position or { 0, 0, 0 }

    o.Components = {}
    if components ~= nil then
        for k,v in pairs(components) do
            o:AddComponent(v)
        end
    end
    o:Register()
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
    local items = ENTITY.Items
    for k,v in ipairs(items) do
        v:InternalUpdate(dt)
    end

    for k,v in ipairs(ENTITY.ItemsToDestroy) do
        v:Unregister()
        v.Components = {}
        for j,item in ipairs(items) do
            if item == v then
                items[j] = ENTITY.Items[#items]
                items[#items] = nil
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

function ENTITY:AddComponent(desc)
    local component, properties, constructor

    constructor = _G["COMPONENT_" .. desc.Type]
    properties = desc.Properties

    if not constructor then
        error("LCS: Unknown component <" .. desc.Type .. ">")
    end

    component = constructor(properties,self)

    table.insert(self.Components, component)
end

function ENTITY:Register()
    for k,v in ipairs(self.Components) do
        if v.Register then
            v:Register()
        end
    end
    self.ItIsRegistered = true
end

function ENTITY:Unregister()
    for k,v in ipairs(self.Components) do
        if v.Unregister then
            v:Unregister()
        end
    end
    self.ItIsRegistered = false
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

function ENTITY:PreRender()
    for k,v in ipairs(self.Components) do
        v:PreRender()
    end
end

function ENTITY:Destroy()
    table.insert(ENTITY.ItemsToDestroy,self)
    self.ItIsDestroyed = true
end

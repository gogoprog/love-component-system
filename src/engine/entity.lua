function entity_class(base, init)
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

    if base == nil and ENTITY ~= nil then
        base = ENTITY
    end

    --c.__index = c

    c.__index = function(t,key)
        if c[key] == nil then
            for k,v in ipairs(t.Components) do
                if v[key] ~= nil then
                    return v[key]
                end
            end
        end

        return c[key]
    end

    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj,c)

        if base and base.init then
            base.init(obj, ...)
        end

        if init then
            init(obj,...)
        end
        return obj
    end

    c.init = init
    c.is_a = function(self, klass)
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

ENTITY = entity_class(function(o,components)
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

function ENTITY:HandleEvent(event, parameters)
    local string = "On" .. event

    if self[string] ~= nil then
        self[string](self, parameters)
    end
end
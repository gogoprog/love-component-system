function class(base, init)
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

    c.__index = function(t,key)
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
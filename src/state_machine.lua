
STATE_MACHINE = STATE_MACHINE or {}


function STATE_MACHINE.MissingState(k)
    if k == nil then
        print( "State is nil!")
    elseif type(k) == 'function' then
        print( "Missing state!")
    else
        print( "Missing state : " .. k .. " !")
    end
end

function STATE_MACHINE.Implement(o)
    o.State = nil
    o.OnStateEnter = {}
    setmetatable(o.OnStateEnter, { __index = function(t,k) return function() end end })
    o.OnStateUpdate = {}
    setmetatable(o.OnStateUpdate, { __index = function(t,k) STATE_MACHINE.MissingState(k) return function() end end })
    o.OnStateExit = {}
    setmetatable(o.OnStateExit, { __index = function(t,k) return function() end end })

    o.ChangeState = function(state)
        o.OnStateExit[o.State]()
        o.OnStateEnter[state]()
        o.State = state
    end

    o.UpdateState = function(...)
        o.OnStateUpdate[o.State](...)
    end
end

function STATE_MACHINE.ImplementInClass(_class)
    _class.OnStateEnter = {}
    setmetatable(_class.OnStateEnter, { __index = function(t,k) return function() end end })
    _class.OnStateUpdate = {}
    setmetatable(_class.OnStateUpdate, { __index = function(t,k) STATE_MACHINE.MissingState(k) return function() end end })
    _class.OnStateExit = {}
    setmetatable(_class.OnStateExit, { __index = function(t,k) return function() end end })

    _class.ChangeState = function(s,state)
        if s.OnStateExit and s.OnStateExit[s.State] then s.OnStateExit[s.State](s) end
        if s.OnStateEnter and s.OnStateEnter[state] then s.OnStateEnter[state](s) end
        s.State = state
    end

    _class.UpdateState = function(s, ...)
        s.OnStateUpdate[s.State](s, ...)
    end
end

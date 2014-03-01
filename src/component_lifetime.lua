COMPONENT_LIFETIME= class(function(o,parameters,entity)
    o.Entity = entity
    o.Time = parameters.Time or 1
end)

-- METHODS

function COMPONENT_LIFETIME:Update(dt)
    self.Time = self.Time - dt

    if self.Time < 0 then
        self.Entity:Destroy()
    end
end

function COMPONENT_LIFETIME:PreRender()

end

function COMPONENT_LIFETIME:Render()
end
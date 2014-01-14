CAMERA = entity_class(function(o)
    local description = {
        {
            Type = "CAMERA",
            Properties = {
                Extent = {800,600}
            }
        }
    }

    ENTITY.Init(o,description)

    o.ShakeTimeLeft = 0
end)


function CAMERA:Update(dt)
    self.ShakeTimeLeft = self.ShakeTimeLeft - dt

    if self.ShakeTimeLeft > 0 then
        self.Position = {
            math.random(-3,3),
            math.random(-3,3)
        }
    else
        self.Position = {0,0}
    end
end

function CAMERA:Shake(t)
    self.ShakeTimeLeft = t
end
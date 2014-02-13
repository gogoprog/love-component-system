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
end)


function CAMERA:Update(dt)

end

function CAMERA:Shake(t)

end
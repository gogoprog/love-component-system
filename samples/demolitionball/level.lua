LEVEL = class(function(o)

end)

function LEVEL:Load()
    local world_description = {
        {
            Type = "PHYSIC_WORLD",
            Properties = {
            }
        }
    }

    ENTITY(world_description)

    local ground_description = {
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "rectangle",
                Extent = {10240,4*15},
                Type = "static",
                Density = 1
            }
        }
    }

    ENTITY(ground_description,{0,600})

    self:GenerateTower(200)
    self:GenerateTower(400)
    self:GenerateTower(600)

end

function LEVEL:GetCrateDescription(extent)
    local description = {
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "rectangle",
                Extent = extent,
                Type = "dynamic"
            }
        },
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("crate" .. math.random(1,3)),
                Extent = extent
            }
        }
    }
    return description
end

function LEVEL:GenerateRandomCrates()
    for i=1,10 do
        local extent = {math.random(1,4) * 16,math.random(1,4) * 16}
        local pos = {math.random(0,800),math.random(0,300)}
        ENTITY(self:GetCrateDescription(extent),pos)
    end
end


function LEVEL:GenerateTower(x)
    local last_y = 560
    for i=1,20 do
        local extent = {math.random(1,4) * 16,math.random(1,4) * 16}
        local pos = {x,last_y - extent[2] * 0.5}
        ENTITY(self:GetCrateDescription(extent),pos)
        last_y = pos[2] - extent[2] * 0.5
    end
end
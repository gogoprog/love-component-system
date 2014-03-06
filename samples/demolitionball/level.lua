require 'component_breakable'
require 'crates'

LEVEL = class(function(o)

end)

function LEVEL:Init()
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
                Extent = {10240,60},
                Type = "static",
                Density = 1
            }
        }
    }

    ENTITY(ground_description,{0,600})
end

function LEVEL:Test()
    self:GenerateTower(200)
    self:GenerateTower(400)
    self:GenerateTower(600)
    self:GenerateTower(800)
    self:GenerateTower(1000)
    self:GenerateTower(1200)
end

function LEVEL:GetCrateDescription(extent,density,texture)
    local description = {
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "rectangle",
                Extent = extent,
                Type = "dynamic",
                Density = density
            }
        },
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("crate1_0"),
                Extent = extent
            }
        },
        {
            Type = "BREAKABLE",
            Properties = {
                TexturesNames = { "crate1_0", "crate1_1", "crate1_2" }
            }
        }
    }
    return description
end

function LEVEL:GenerateTower(x)
    local last_y = 570
    local names={"Small","Big"}
    for i=1,10 do
        local name = names[math.random(1,2)]
        local extent = CRATES.List[name].Extent
        local pos = {x,last_y - extent[2] * 0.5}
        local e = ENTITY(CRATES.GetDescription(name), pos)
        last_y = pos[2] - extent[2] * 0.5
    end
end
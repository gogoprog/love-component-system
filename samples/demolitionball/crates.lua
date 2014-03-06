CRATES = {}


CRATES.List = {
    Small = {
        Extent = {32,32},
        Textures = {"crate1_0", "crate1_1", "crate1_2"},
        Density = 100
    },
    Big = {
        Extent = {64,64},
        Textures = {"crate2_0", "crate2_1", "crate2_2", "crate2_3"},
        Density = 200
    }
}

function CRATES.GetDescription(name)
    local crate = CRATES.List[name]
    local description = {
        {
            Type = "PHYSIC",
            Properties = {
                Shape = "rectangle",
                Extent = crate.Extent,
                Type = "dynamic",
                Density = crate.Density
            }
        },
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get(crate.Textures[1]),
                Extent = crate.Extent
            }
        },
        {
            Type = "BREAKABLE",
            Properties = {
                TexturesNames = crate.Textures
            }
        }
    }

    return description
end
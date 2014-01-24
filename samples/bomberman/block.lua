BLOCK = entity_class(function(o,x,y)
    local ss = SPRITE_SHEET.Get("main")
    local description = {
        {
            Type = "SPRITE",
            Properties = {
                Texture = ss.Source,
                Quad = ss:GetQuad("tree"),
                Extent = {32,32},
                Layer = 1
            }
        },
        {
            Type = "BOUNDING",
            Properties = {
                Shape = "rectangle",
                Extent = {32,32}
            }
        }
    }

    ENTITY.Init(o,description,{x,y})
    o.ItIsDestroyable = true
end)

function BLOCK:Update(dt)

end


PLAYER = entity_class(function(o,x,y)
    local description = {
        {
            Type = "ANIMATED_SPRITE",
            Properties = {
                Animation = ANIMATION.Get("idle"),
                Extent = {32,32},
                Layer = 1
            }
        }
    }

    ENTITY.Init(o,description,{x,y})
end)

function PLAYER.Load()
    local source = love.graphics.newImage("data/man.png")

    ANIMATION.Create("idle",{
        Source = source,
        CellWidth = 32,
        CellHeight = 32,
        Frames = { 0,1,2 },
        FrameRate = 8
        })
end
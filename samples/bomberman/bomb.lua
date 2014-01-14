BOMB = entity_class(function(o,x,y,game,gx,gy)
    local description = {
        {
            Type = "SPRITE",
            Properties = {
                Texture = BOMB.Texture,
                Extent = {32,32},
                Layer = 1
            }
        }
    }

    ENTITY.Init(o,description,{x,y})
    o.Game = game
    o.GridX = gx
    o.GridY = gy
    o.TimeLeft = 2
end)

function BOMB.Load()
    BOMB.Texture = love.graphics.newImage("data/bomb.png")
end

function BOMB:Update(dt)
    self.Orientation = self.Orientation + dt * 6

    self.TimeLeft = self.TimeLeft - dt

    if self.TimeLeft <= 0 then
        self.Game:RemoveGridItem(self.GridX, self.GridY)
        self:Destroy()
    end
end
BOMB = entity_class(function(o,x,y,game,gx,gy, size)
    local description = {
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("bomb"),
                Extent = {32,32},
                Layer = 1
            }
        }
    }

    ENTITY.Init(o,description,{x,y})
    o.Game = game
    o.GridX = gx
    o.GridY = gy
    o.Size = size
    o.TimeLeft = 2
    o.ItIsBomb = true
end)

function BOMB:Update(dt)
    self.Orientation = self.Orientation + dt * 6

    self.TimeLeft = self.TimeLeft - dt

    if self.TimeLeft <= 0 then
        self:Explode()
    end
end

function BOMB:Explode()
    self.Game:StartExplosion(self.GridX,self.GridY,self.Size)
    self.Game:RemoveItem(self.GridX, self.GridY)
    self:Destroy()
end
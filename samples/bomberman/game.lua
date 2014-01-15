require 'level'
require 'player'
require 'bomb'
require 'explosion'
require 'camera'

GAME = class(function(o)
    o.Grid = {}
end)

function GAME:Load()
    TEXTURE.Load("bomb","data/bomb.png")

    TEXTURE.Load("man","data/man.png")

    ANIMATION.Create("idle",{
        Source = TEXTURE.Get("man"),
        CellWidth = 32,
        CellHeight = 32,
        Frames = { 0,1,2 },
        FrameRate = 8
        })

    TEXTURE.Load("cloud","data/cloud.png")
end

function GAME:NewGame()
    ENTITY.DestroyAll()
    self.Level = LEVEL()
    self.Level:Initialize(self)
    self.Player = PLAYER(74,64,self)
    self.Camera = CAMERA()
end

function GAME:Update(dt)

end

function GAME:IsPlaceFree(gx,gy)
    if self.Grid[gx] == nil then
        self.Grid[gx] = {}
    end

    if self.Grid[gx][gy] == nil then
        return true
    end

    return false
end

function GAME:PlaceItem(gx,gy, what)
    if self.Grid[gx] == nil then
        self.Grid[gx] = {}
    end

    if self.Grid[gx][gy] == nil then
        self.Grid[gx][gy] = what
    end
end

function GAME:RemoveItem(gx,gy)
   self.Grid[gx][gy] = nil
end

function GAME:PlaceBomb(x,y)
    local lvl = self.Level
    local gx,gy = lvl:GetGridPosition(x,y)

    if self:IsPlaceFree(gx,gy) then
        self:PlaceItem(gx,gy, BOMB(gx * lvl.CellSize, gy * lvl.CellSize, self, gx, gy))
    end
end

function GAME:BlockGrid(x,y)
    local lvl = self.Level
    local gx,gy = lvl:GetGridPosition(x,y)

    self:PlaceItem(gx,gy,"blocked")
end

function GAME:StartExplosion(gx,gy)
    EXPLOSION(gx,gy,self,"all")
    self.Camera:Shake(1)
end


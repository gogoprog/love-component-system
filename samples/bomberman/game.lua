require 'level'
require 'player'
require 'bomb'

GAME = class(function(o)
    o.Grid = {}
end)

function GAME:Initialize()
    BOMB.Load()
    PLAYER.Load()
    self.Level = LEVEL()
    self.Level:Initialize()
    self.Player = PLAYER(74,64,self)
end

function GAME:Update(dt)

end

function GAME:PlaceBomb(x,y)
    local lvl = self.Level
    local gx,gy = lvl:GetGridPosition(x,y)

    if self.Grid[gx] == nil then
        self.Grid[gx] = {}
    end

    if self.Grid[gx][gy] == nil then
        self.Grid[gx][gy] = BOMB(gx * lvl.CellSize, gy * lvl.CellSize, self, gx, gy)
    end
end

function GAME:RemoveGridItem(gx,gy)
   self.Grid[gx][gy] = nil
end
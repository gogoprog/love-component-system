require 'level'
require 'player'

GAME = class(function(o)
    
end)

function GAME:Initialize()
    PLAYER.Load()
    self.Level = LEVEL()
    self.Level:Initialize()
    self.Player = PLAYER(400,300)
end

function GAME:Update(dt)

end
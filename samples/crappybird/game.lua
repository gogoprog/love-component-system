require 'level'
require 'camera'
require 'bird'

GAME = class(function(o)
    o.Level = LEVEL()
    o.LastMouseDown = false
end)

function GAME:Load()
    TEXTURE.Load("bird","data/angry_bird.png")
    TEXTURE.Load("cloud","data/cloud.png")
    TEXTURE.Load("tiles","data/tiles.png")

    local ss = SPRITE_SHEET.Create("sky",TEXTURE.Get("cloud"),32,32)
    ss:AddQuad("cloud",0,0,1,1)

    ss = SPRITE_SHEET.Create("tiles",TEXTURE.Get("tiles"),15,15)
    ss:AddQuad("block",0,0,1,1)
end

function GAME:NewGame()
    ENTITY.DestroyAll()

    self.GameIsOver = false

    self.Camera = CAMERA()
    self.Level:Load()

    self.Bird = BIRD()
    self.Bird.Game = self
end

function GAME:Update(dt)
    if not self.GameIsOver then
        local birdpos = self.Bird.Position
        
        birdpos[1] = birdpos[1] + dt * 200

        self.Bird:SetPosition(birdpos[1], birdpos[2])

        self.Camera.Position[1] = birdpos[1] - 200

        local mouse_is_down = love.mouse.isDown('l')
        if mouse_is_down and not self.LastMouseDown then
            self.Bird:SetLinearVelocity(0,-300)
        end
        self.LastMouseDown = mouse_is_down


        self.Level:Update(dt)
    else
        self.Time = self.Time - dt
        if self.Time < 0 then
            self:NewGame()
        end
    end

end

function GAME:GameOver()
    self.GameIsOver = true
    self.Time = 3
end
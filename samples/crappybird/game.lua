require 'level'
require 'camera'
require 'bird'

GAME = class(function(o)
    o.Level = LEVEL()
    o.MouseIsDown = false
    o.MouseIsJustDown = false
    o.PreviousMouseIsDown = false
end)

STATE_MACHINE.ImplementInClass(GAME)

local title_font, font

function GAME:Load()
    TEXTURE.Load("bird","data/angry_bird.png")
    TEXTURE.Load("cloud","data/cloud.png")
    TEXTURE.Load("tiles","data/tiles.png")

    local ss = SPRITE_SHEET.Create("sky",TEXTURE.Get("cloud"),32,32)
    ss:AddQuad("cloud",0,0,1,1)

    ss = SPRITE_SHEET.Create("tiles",TEXTURE.Get("tiles"),15,15)
    ss:AddQuad("block",0,0,1,1)

    title_font = love.graphics.newFont("data/game_boy.ttf",72)
    font = love.graphics.newFont("data/game_boy.ttf",24)
end

function GAME:NewGame()
    ENTITY.DestroyAll()

    self.Camera = CAMERA()
    self.Level:Load()
end

function GAME:Update(dt)
    self.MouseIsDown = love.mouse.isDown('l')
    if self.MouseIsDown and not self.PreviousMouseIsDown then
        self.MouseIsJustDown = true
    else
        self.MouseIsJustDown = false
    end
    self.PreviousMouseIsDown = self.MouseIsDown

    self:UpdateState(dt)
end

function GAME.OnStateEnter:Menu()
    local descriptions = {
        Title = {
            {
                Type = "TEXT",
                Properties = {
                    Text = "CrappyBird",
                    Layer = 100,
                    Color = {0,0,0,255},
                    Font = title_font
                }
            }
        },
        Text = {
            {
                Type = "TEXT",
                Properties = {
                    Text = "Click to start!",
                    Layer = 100,
                    Color = {0,0,0,255},
                    Font = font
                }
            }
        },
    }

    self:NewGame()

    self.Title = ENTITY(descriptions.Title,{400,100})
    self.Text = ENTITY(descriptions.Text,{400,300})
end

function GAME.OnStateUpdate:Menu(dt)
    self.Camera.Position[1] = self.Camera.Position[1] + dt * 200
    self.Title.Position[1] = self.Camera.Position[1] + 400
    self.Text.Position[1] = self.Camera.Position[1] + 400

    self.Level:Update(dt)

    if self.MouseIsJustDown then
        self:ChangeState("InGame")
    end
end

function GAME.OnStateExit:Menu()
    self.Title:Destroy()
    self.Title = nil
    self.Text:Destroy()
    self.Text = nil
end

function GAME.OnStateEnter:InGame()
    self.Bird = BIRD()
    self.Bird.Game = self
end

function GAME.OnStateUpdate:InGame(dt)
    local birdpos = self.Bird.Position
    
    birdpos[1] = birdpos[1] + dt * 200

    self.Bird:SetPosition(birdpos[1], birdpos[2])

    self.Camera.Position[1] = birdpos[1] - 200

    if self.MouseIsJustDown then
        self.Bird:SetLinearVelocity(0,-300)
    end

    self.Level:Update(dt)
end

function GAME.OnStateUpdate:GameOver(dt)
    self.Time = self.Time - dt
    if self.Time < 0 then
        self:ChangeState("Menu")
    end
end

function GAME:GameOver()
    self.Time = 1
    self:ChangeState("GameOver")
end
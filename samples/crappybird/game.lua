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
    TEXTURE.Load("bird_up","data/bird_up.png")
    TEXTURE.Load("bird_down","data/bird_down.png")
    TEXTURE.Load("lose_up","data/lose_up.png")
    TEXTURE.Load("lose_down","data/lose_down.png")

    TEXTURE.Load("logo","data/logo.png")

    TEXTURE.Load("cloud","data/cloud.png")
    TEXTURE.Load("pipe","data/crappybird_pipe.png")
    TEXTURE.Load("obstacle_v","data/obstacle_v.png")
    TEXTURE.Load("ground","data/ground.png")
    TEXTURE.Load("ceiling","data/ceiling.png")

    local ss = SPRITE_SHEET.Create("sky",TEXTURE.Get("cloud"),32,32)
    ss:AddQuad("cloud",0,0,1,1)

    ss = SPRITE_SHEET.Create("obstacles",TEXTURE.Get("pipe"),64,512)
    ss:AddQuad("obstacle",0,0,1,1)

    ss = SPRITE_SHEET.Create("obstacles_v",TEXTURE.Get("obstacle_v"),64,512)
    ss:AddQuad("obstacle",0,0,1,1)

    ss = SPRITE_SHEET.Create("floors",TEXTURE.Get("ground"),64,64)
    ss:AddQuad("floor",0,0,1,1)

    ss = SPRITE_SHEET.Create("ceilings",TEXTURE.Get("ceiling"),64,64)
    ss:AddQuad("ceiling",0,0,1,1)

    title_font = love.graphics.newFont("data/game_boy.ttf",72)
    font = love.graphics.newFont("data/game_boy.ttf",24)
end

function GAME:NewGame()
    ENTITY.DestroyAll()

    local description = {
        {
            Type = "CAMERA",
            Properties = {
                Extent = {800,600},
                World = 2
            }
        }
    }

    self.MenuCamera = ENTITY(description)

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
                Type = "SPRITE",
                Properties = {
                    Texture = TEXTURE.Get("logo"),
                    World = 2
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
                    Font = font,
                    World = 2
                }
            }
        },
        Credits = {
            {
                Type = "TEXT",
                Properties = {
                    Text = "Gauthier Billot        Ilyas Sfar",
                    Layer = 100,
                    Color = {0,0,0,255},
                    Font = font,
                    World = 2
                }
            }
        }
    }

    self:NewGame()

    self.Title = ENTITY(descriptions.Title,{400,200})
    self.Text = ENTITY(descriptions.Text,{400,350})
    self.Credits = ENTITY(descriptions.Credits,{400,580})
end

function GAME.OnStateUpdate:Menu(dt)
    self.Camera.Position[1] = self.Camera.Position[1] + dt * 100

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
    self.Credits:Destroy()
    self.Credits = nil
end

function GAME.OnStateEnter:InGame()

    local descriptions = {
        Score = {
            {
                Type = "TEXT",
                Properties = {
                    Text = "Score: 00",
                    Layer = 100,
                    Color = {220,230,240,255},
                    Font = font,
                    World = 2
                }
            }
        }
    }

    self.Bird = BIRD()
    self.Bird.Game = self

    self.ScoreText = ENTITY(descriptions.Score,{128,10})
    self.Score = 0
    self.MinusScore = 0
end

function GAME.OnStateUpdate:InGame(dt)
    local birdpos = self.Bird.Position
    
    birdpos[1] = birdpos[1] + dt * 300

    self.Bird.Position = birdpos

    self.Camera.Position[1] = birdpos[1] - 200

    if self.MouseIsJustDown then
        self.Bird:SetLinearVelocity(0,-300)
        self.MinusScore = self.MinusScore + 1
    end

    self.Level:Update(dt)

    local score = self.Level:GetScore(birdpos[1]) - self.MinusScore

    if score ~= self.Score then
        self.Score = score
        self.ScoreText:SetText("Score: " .. string.format("%02i", score), true)
    end
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
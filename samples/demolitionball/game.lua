require 'level'

GAME = class(function(o)
    o.MouseIsDown = false
    o.MouseIsJustDown = false
    o.PreviousMouseIsDown = false
    o.PreviousMousePosition = nil
    o.Level = LEVEL()
end)

STATE_MACHINE.ImplementInClass(GAME)

local title_font, font

function GAME:Load()
    TEXTURE.Load("cloud","data/cloud.png")
    TEXTURE.Load("crate1","data/crate1.png")
    TEXTURE.Load("crate2","data/crate2.png")
    TEXTURE.Load("crate3","data/crate3.png")
    TEXTURE.Load("ball","data/ball.png")

    title_font = love.graphics.newFont("data/game_boy.ttf",72)
    font = love.graphics.newFont("data/game_boy.ttf",24)
end

function GAME:NewGame()
    ENTITY.DestroyAll()
    self.Level:Load()
    self.Camera = ENTITY({
        {
            Type = "CAMERA",
            Properties = {
            }
        }
    })
end

function GAME:Update(dt)
    local cursor_position = {love.mouse.getPosition()}
    self.MouseIsDown = love.mouse.isDown('r')
    if self.MouseIsDown and not self.PreviousMouseIsDown then
        self.MouseIsJustDown = true
    else
        self.MouseIsJustDown = false
    end

    if self.MouseIsDown then
        local delta = {cursor_position[1] - self.PreviousMousePosition[1], cursor_position[2] - self.PreviousMousePosition[2]}
        self.Camera.Position[1] = self.Camera.Position[1] - delta[1]
        self.Camera.Position[2] = self.Camera.Position[2] - delta[2]
    end

    if self.MouseIsJustDown then
        ENTITY({
            {
                Type = "PHYSIC",
                Properties = {
                    Shape = "circle",
                    Radius = 7,
                    Type = "dynamic",
                    Density = 1000
                }
            },
            {
                Type = "SPRITE",
                Properties = {
                    Texture = TEXTURE.Get("ball")
                }
            }
        }, cursor_position)
    end

    self.PreviousMouseIsDown = self.MouseIsDown

    self:UpdateState(dt)
    self.PreviousMousePosition = cursor_position
end

function GAME.OnStateEnter:Menu()
    self:NewGame()
end

function GAME.OnStateUpdate:Menu(dt)

    if self.MouseIsJustDown then
        self:ChangeState("InGame")
    end
end

function GAME.OnStateExit:Menu()

end

function GAME.OnStateEnter:InGame()


end

function GAME.OnStateUpdate:InGame(dt)

end

function GAME.OnStateUpdate:GameOver(dt)

end

function GAME:GameOver()

end
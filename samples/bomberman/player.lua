PLAYER = entity_class(function(o,x,y,game)
    local description = {
        {
            Type = "ANIMATED_SPRITE",
            Properties = {
                Animation = ANIMATION.Get("idle"),
                Extent = {32,32},
                Layer = 1
            }
        },
        {
            Type = "BOUNDING",
            Properties = {
                Shape = "rectangle",
                Extent = {28,28}
            }
        }
    }

    ENTITY.Init(o,description,{x,y})

    local level = game.Level
    o.Level = level

    o.Game = game

    local cx,cy = level:GetCorrectedPosition(x,y)
    o.Position = {cx,cy}

    o.ItIsDead = false
end)

function PLAYER:Update(dt)
    if not self.ItIsDead then
        local kb = love.keyboard
        local move = {0,0}
        local speed = 128
        local p = self.Position

        if kb.isDown('right') then
            move[1] = move[1] + speed * dt
            self:SetAnimation(ANIMATION.Get("move_right"))
        end

        if kb.isDown('left') then
            move[1] = move[1] - speed * dt
            self:SetAnimation(ANIMATION.Get("move_left"))
        end

        if kb.isDown('up') then
            move[2] = move[2] - speed * dt
            self:SetAnimation(ANIMATION.Get("move_up"))
        end

        if kb.isDown('down') then
            move[2] = move[2] + speed * dt
            self:SetAnimation(ANIMATION.Get("move_down"))
        end

        if move[1] ~= 0 or move[2] ~= 0 then

            if not self:TryMove(move[1], move[2]) then
                if not self:TryMove(move[1], 0) then
                    self:TryMove(0, move[2])
                end
            end
        else
            self:SetAnimation(ANIMATION.Get("idle"))
        end

        if kb.isDown('b') then
            self.Game:PlaceBomb(p[1],p[2],1)
        end

        if kb.isDown('v') then
            self.Game:PlaceBomb(p[1],p[2],10)
        end
    else
        self.Orientation = self.Orientation + dt * 20
    end
end

function PLAYER:GetGridPosition()
    local p = self.Position
    return self.Game.Level:GetGridPosition(
        p[1],
        p[2]
        )
end

function PLAYER:Die()
    self.ItIsDead = true
end

function PLAYER:TryMove(ox,oy)
    local p = self.Position
    local safe = {p[1],p[2]}
    local colsize = 28

    p[1] = p[1] + ox
    p[2] = p[2] + oy

    if self:CollidesWithWorld() == true then
        self.Position = safe
        return false
    end

    return true
end
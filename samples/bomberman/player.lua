PLAYER = entity_class(function(o,x,y,game)
    local description = {
        {
            Type = "ANIMATED_SPRITE",
            Properties = {
                Animation = ANIMATION.Get("idle"),
                Extent = {32,32},
                Layer = 1
            }
        }
    }

    ENTITY.Init(o,description,{x,y})

    local level = game.Level
    o.Level = level
    o.Colliding = false
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

        if not self.Colliding then

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
                self.LastPosition = {p[1],p[2]}

                if not self:TryMove(move[1], move[2]) then
                    if not self:TryMove(move[1], 0) then
                        self:TryMove(0, move[2])
                    end
                end
            else
                self:SetAnimation(ANIMATION.Get("idle"))
            end
        else
            self.Position = {self.LastPosition[1],self.LastPosition[2]}
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
    local colsize = 28
    local result = self.Level:Collides(p[1]+ox,p[2]+oy,colsize,colsize)

    if not result then
        p[1] = p[1] + ox
        p[2] = p[2] + oy

        return true
    end

    return false
end
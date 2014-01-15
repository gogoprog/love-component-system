EXPLOSION = entity_class(function(o,gx,gy,game,propagation)
    local description = {
        {
            Type = "PARTICLE",
            Properties = {
                Layer = 2
            }
        }
    }
    local cs = game.Level.CellSize
    ENTITY.Init(o,description,{gx*cs,gy*cs})
    o.Game = game
    o.GridX = gx
    o.GridY = gy
    o.TimeLeft = 5
    o.PropagationTimeLeft = 0.1
    o.Propagation = propagation
    o.PropagationIsDone = false

    local ps = love.graphics.newParticleSystem(TEXTURE.Get("cloud"), 30)
    ps:setEmissionRate(10)
    ps:setParticleLifetime(0.5)
    ps:setEmitterLifetime(0.8)
    ps:setSizes(1,1.5,1)
    ps:setColors(255,255,255,255,255,128,0,255,0,0,0,0)
    ps:setSpin(20)

    o:AddParticleSystem(ps,false)
end)

function EXPLOSION:Update(dt)
    self.TimeLeft = self.TimeLeft - dt
    self.PropagationTimeLeft = self.PropagationTimeLeft - dt

    if self.PropagationIsDone == false then
        if self.PropagationTimeLeft <= 0 then
            self.PropagationIsDone = true
            local game = self.Game
            local gx,gy = self.GridX, self.GridY

            if self.Propagation == "all" then
                local px,py = 0,0

                for px = -1,1,2 do
                    if self.Game:IsPlaceFree(gx+px,gy+py) then
                        EXPLOSION(gx+px,gy+py,game,{px,py})
                    end
                end

                for py = -1,1,2 do
                    if self.Game:IsPlaceFree(gx+px,gy+py) then
                        EXPLOSION(gx+px,gy+py,game,{px,py})
                    end
                end

            else
                local px,py = self.Propagation[1], self.Propagation[2]
                if self.Game:IsPlaceFree(gx+px,gy+py) then
                    EXPLOSION(gx+px,gy+py,game,{px,py})
                end
            end
        end
    end

    if self.TimeLeft <= 0 then
        self:Destroy()
    end
end
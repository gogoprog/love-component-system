
PLAYER = entity_class(function(o,x,y,level)
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

    o.Level = level
    o.Colliding = false
end)

function PLAYER.Load()
    local source = love.graphics.newImage("data/man.png")

    ANIMATION.Create("idle",{
        Source = source,
        CellWidth = 32,
        CellHeight = 32,
        Frames = { 0,1,2 },
        FrameRate = 8
        })
end

function PLAYER:Update(dt)
    local kb = love.keyboard
    local move = {0,0}
    local speed = 128
    local p = self.Position

    if not self.Colliding then

        if kb.isDown('right') then
            move[1] = move[1] + speed * dt
        end

        if kb.isDown('left') then
            move[1] = move[1] - speed * dt
        end

        if kb.isDown('up') then
            move[2] = move[2] - speed * dt
        end

        if kb.isDown('down') then
            move[2] = move[2] + speed * dt
        end

        if move[1] ~= 0 or move[2] ~= 0 then
            self.LastPosition = {p[1],p[2]}
            
            if not self.Level:Collides(p[1]+move[1],p[2]+move[2],32,32) then
                p[1] = p[1] + move[1]
                p[2] = p[2] + move[2]
            elseif not self.Level:Collides(p[1]+move[1],p[2],32,32) then
                p[1] = p[1] + move[1]
            elseif not self.Level:Collides(p[1],p[2]+move[2],32,32) then
                p[2] = p[2] + move[2]
            end
        end
    else
        self.Position = {self.LastPosition[1],self.LastPosition[2]}
    end
end

function PLAYER:OnCollisionBegin()
    --self.Colliding = true
end


function PLAYER:OnCollisionEnd()
    --self.Colliding = false
end
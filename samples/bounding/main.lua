require 'lcs.engine'

-- Locals

local descriptions = {
    World = {
        {
            Type = "BOUNDING_WORLD",
            Properties = {
            }
        }
    },
    Block = {
        {
            Type = "QUAD",
            Properties = {
                Extent = {64,64}
            }
        },
        {
            Type = "BOUNDING",
            Properties = {
                Extent = {64,64}
            }
        }
    },
}

-- Callbacks

local world, block, userblock

function love.load(arg)
    ENGINE.Initialize(arg)
    world = ENTITY(descriptions.World)
    block = ENTITY(descriptions.Block,{400,300})

    userblock = ENTITY(descriptions.Block,{400,300})
end

local x1,y1,x2,y2 = 20,250,300,40

function love.update(dt)
    ENGINE.Update(dt)

    local x,y = love.mouse.getPosition()
    userblock.Position = {x,y}

    if userblock:CollidesWithWorld() or userblock:Intersects(x1,y1,x2,y2) then
        userblock:SetQuadColor({255,0,0,255})
    else
        userblock:SetQuadColor({255,255,255,255})
    end
end

function love.draw()
    love.graphics.setColor(255,255,255,255)
    love.graphics.line(x1,y1,x2,y2)
    ENGINE.Render()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.push("quit")
    end
end
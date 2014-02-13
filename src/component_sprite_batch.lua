require 'lcs.class'

COMPONENT_SPRITE_BATCH = class(function(o,parameters,entity)
    o.SpriteSheet = parameters.SpriteSheet
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.Batch = love.graphics.newSpriteBatch(o.SpriteSheet.Source, parameters.Size or 1024)
end)

-- METHODS

function COMPONENT_SPRITE_BATCH:Bind()
    COMPONENT_SPRITE_BATCH.Current = self.Batch
    self.Batch:bind()
end

function COMPONENT_SPRITE_BATCH:Unbind()
    self.Batch:unbind()
    COMPONENT_SPRITE_BATCH.Current = nil
end

function COMPONENT_SPRITE_BATCH:Update()
end

function COMPONENT_SPRITE_BATCH:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_SPRITE_BATCH:Render()
    love.graphics.setColor(255,255,255,255)
    local p = self.Entity.Position
    love.graphics.draw(
        self.Batch,
        p[1],
        p[2]
        )
end

function COMPONENT_SPRITE_BATCH:AddSpriteQuad(q,x,y,r,sx,sy)
    local qx,qy,w,h = q:getViewport()
    self.Batch:add(
        q,
        x,
        y,
        r,
        sx,
        sy,
        w * 0.5,
        h * 0.5
        )
end

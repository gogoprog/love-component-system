require 'lcs.class'

COMPONENT_SPRITE_BATCH = class(function(o,parameters,entity)
    o.SpriteSheet = parameters.SpriteSheet
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.Batch = love.graphics.newSpriteBatch(o.SpriteSheet.Source, parameters.Size or 1024)
    o.Entity.SpriteBatch = o.Batch
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
    local p = self.Entity.Position
    love.graphics.draw(
        self.Batch,
        p[1],
        p[2]
        )
end
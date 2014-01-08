require 'lcs.class'

COMPONENT_TEXT = class(function(o,parameters,entity)
    o.Layer = parameters.Layer or 1
    o.Entity = entity
    o.Font = love.graphics.getFont()
    o.Extent = parameters.Extent or {o.Font:getWidth(parameters.Text), o.Font:getHeight()}
    o:SetText(parameters.Text)
end)

-- METHODS

function COMPONENT_TEXT:Update()
end

function COMPONENT_TEXT:PreRender()
    ENGINE.AddRenderable(self,self.Layer)
end

function COMPONENT_TEXT:Render()
    local p = self.Entity.Position
    love.graphics.print(
        self.Text,
        p[1],
        p[2],
        self.Entity.Orientation,
        self.ScaleX,
        self.ScaleY,
        self.OffsetX,
        self.OffsetY
        )
end

function COMPONENT_TEXT:SetText(text)
    local w = self.Font:getWidth(text)
    local h = self.Font:getHeight()

    self.Text = text
    self.OffsetX = w * 0.5
    self.OffsetY = h * 0.5

    self.ScaleX = self.Extent[1] / w
    self.ScaleY = self.Extent[2] / h
end


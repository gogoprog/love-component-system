require 'lcs.class'

CAMERA = class(function(o,position)
    o.Position = position
end)

-- METHODS

function CAMERA:PreRender()
    love.graphics.origin()

    local p = self.Position
    love.graphics.translate(-p[1],-p[2])
end


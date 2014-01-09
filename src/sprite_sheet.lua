SPRITE_SHEET = class(function(o, source, tile_width, tile_height)
    o.Source = source
    o.Width = source:getWidth()
    o.Height = source:getHeight()
    o.Quads = {}
    o.TileWidth = tile_width or 1
    o.TileHeight = tile_height or 1
end)

function SPRITE_SHEET:AddQuad(name,x,y,w,h)
    local q
    local tile_width = self.TileWidth
    local tile_height = self.TileHeight

    q = love.graphics.newQuad(x * tile_width, y * tile_height, w * tile_width, h * tile_height,
    self.Width, self.Height)

    self.Quads[name] = q
end

function SPRITE_SHEET:GetQuad(name)
    return self.Quads[name]
end
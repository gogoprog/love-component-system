TEXTURE = {
    Items = {}
}

function TEXTURE.Load(name, filepath)
    TEXTURE.Items[name] = love.graphics.newImage(filepath)
end

function TEXTURE.Get(name)
    return TEXTURE.Items[name]
end
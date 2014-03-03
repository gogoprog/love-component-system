TEXTURE = {
    Items = {}
}

function TEXTURE.Load(name, filepath)
    TEXTURE.Items[name] = love.graphics.newImage(filepath)

    return TEXTURE.Items[name]
end

function TEXTURE.Get(name)
    return TEXTURE.Items[name]
end

function TEXTURE.LoadDirectory(dir)
    local files = love.filesystem.getDirectoryItems(dir)
    for k, file in ipairs(files) do
        if string.sub(file,-4) == ".png" then
            local c = string.find(file,".png")
            local name = string.sub(file,1,c-1)
            TEXTURE.Load(name, dir .. "/" .. file)
        end
    end
end
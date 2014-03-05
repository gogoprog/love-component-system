
EDITOR = class(function(o)
    EDITOR.Instance = o
end)

STATE_MACHINE.ImplementInClass(EDITOR)

function EDITOR:New()
    self.Cannon = ENTITY({
        {
            Type = "SPRITE",
            Properties = {
                Texture = TEXTURE.Get("ball"),
                Extent = {16,64}
            }
        },
        {
            Type = "CANNON",
            Properties = {
            }
        }
    }, {20, 500})
end

function EDITOR:Update(dt)

end

function EDITOR:OnKeyPressed(key)
    local e
    if key == 'a' then
        e = ENTITY(CRATES.GetDescription("Small"), GAME.Instance.MouseWorldPosition)
    end
    if key == 'z' then
        e = ENTITY(CRATES.GetDescription("Big"), GAME.Instance.MouseWorldPosition)
    end
end
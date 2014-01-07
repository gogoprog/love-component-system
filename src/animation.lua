ANIMATION = class(function(o, data)
    o.Time = 0
    o.Frame = 0
    o.Data = data
end)

ANIMATION.Items = {}

function ANIMATION.Create(name, parameters)
    local item = {}
    local sw = parameters.Source:getWidth()
    local sh = parameters.Source:getHeight()
    local width = parameters.CellWidth
    local height = parameters.CellHeight
    local cells_per_lines = sw / width

    item.Parameters = parameters
    item.Quads = {}

    for v,f in ipairs(parameters.Frames) do
        local x = f % cells_per_lines
        local y = math.floor(f / cells_per_lines)
        local q = love.graphics.newQuad(
            x * width,
            y * height,
            width,
            height,
            sw,
            sh
            )
        table.insert(item.Quads,q)
    end

    item.TimePerFrame = ( 1 / parameters.FrameRate )
    item.Duration = #parameters.Frames * item.TimePerFrame
    item.FrameCount = #parameters.Frames

    ANIMATION.Items[name] = item
end

function ANIMATION.Get(name)
    return ANIMATION.Items[name]
end

function ANIMATION:Update(dt)
    self.Time = self.Time + dt
    self.Frame = math.floor((self.Time / self.Data.Duration) * self.Data.FrameCount) + 1
    self.Frame = math.min(self.Frame, self.Data.FrameCount)

    if self.Time >= self.Data.Duration then
        self.Time = 0
    end
end

function ANIMATION:Render(x,y)
    love.graphics.draw(
        self.Data.Parameters.Source,
        self.Data.Quads[self.Frame],
        x,
        y,
        0
        )
end
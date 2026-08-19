local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind("SUPER + Z", zoom)
hl.bind("SUPER + equal", function()
    zoom(0.5)
end)
hl.bind("SUPER + minus", function()
    zoom(-0.5)
end)

hl.layout.register("grid", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then
            return
        end

        local cols = math.ceil(math.sqrt(n))

        for i, target in ipairs(ctx.targets) do
            target:place(ctx:grid_cell(i, cols))
        end
    end,
})

hl.layout.register("circle", {
    recalculate = function(ctx)
        local sin, cos = math.sin, math.cos

        local r = math.min(ctx.area.h, ctx.area.w) / 2 * 0.9
        local n = #ctx.targets

        for i, target in ipairs(ctx.targets) do
            local radians = i / n * math.pi * 2

            local width = 500
            local heigth = 300

            local box = {
                x = ctx.area.w / 2 + cos(radians) * r - width / 2,
                y = ctx.area.h / 2 + sin(radians) * r - heigth / 2,
                w = width,
                h = heigth,
            }
            target:place(box)
        end
    end,
})

hl.workspace_rule({ workspace = "99", layout = "lua:grid" })
hl.workspace_rule({ workspace = "98", layout = "lua:circle" })

local function switch_layout(layout_name)
    local ws = hl.get_active_workspace()

    if ws == nil then
        return
    end

    if ws.tiled_layout ~= layout_name then
        hl.workspace_rule({ workspace = ws.name, layout = layout_name })
    else
        hl.workspace_rule({ workspace = ws.name, layout = "dwindle" })
    end
end

hl.bind("SUPER + SHIFT + G", function()
    switch_layout("lua:grid")
end)

hl.bind("SUPER + SHIFT + C", function()
    switch_layout("lua:circle")
end)

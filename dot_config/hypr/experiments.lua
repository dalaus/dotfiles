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

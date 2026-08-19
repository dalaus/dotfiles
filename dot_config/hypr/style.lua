-- https://wiki.hypr.land/FAQ/#how-do-i-change-me-mouse-cursor
hl.env("XCURSOR_SIZE", 36)
hl.env("HYPRCURSOR_SIZE", 36)
hl.env("XCURSOR_THEME", "phinger-cursors-light")
hl.env("HYPRCURSOR_THEME", "phinger-cursors-light")

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprctl setcursor phinger-cursors-light 36")
end)

return {
    apply = function(noctalia)
        local colors = noctalia.colors

        hl.config({
            general = {
                gaps_in = 3,
                gaps_out = 5,
                border_size = 2,
                col = {
                    active_border = { colors = { colors.primary, colors.surface }, angle = 90 },
                    inactive_border = colors.surface,
                },
                resize_on_border = true,
                allow_tearing = false,
            },
        })

        -- https://wiki.hypr.land/Configuring/Variables/#decoration

        hl.config({
            decoration = {
                rounding = 16,
                rounding_power = 2,
                -- Change transparency of focused and unfocused windows
                active_opacity = 1,
                inactive_opacity = 1,
                shadow = {
                    enabled = true,
                    range = 4,
                    render_power = 3,
                    color = colors.surface,
                },
                -- https://wiki.hypr.land/Configuring/Variables/#blur
                blur = {
                    enabled = true,
                    size = 3,
                    passes = 1,
                    vibrancy = 0.1696,
                },
            },
            misc = {
                force_default_wallpaper = 0,
                disable_hyprland_logo = true,
            },
        })
    end,
}

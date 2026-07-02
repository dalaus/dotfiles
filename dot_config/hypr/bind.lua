local mainMod = "SUPER"

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind("CONTROL + ALT + Delete", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("ghostty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("fuzzel"))
hl.bind("Print", hl.dsp.exec_cmd("flameshot gui -c -p ~/stuff/pic/"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("flameshot full -c -p ~/stuff/pic/"))
hl.bind("Scroll_Lock", hl.dsp.exec_cmd("flameshot gui"))

hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("hyprctl dispatch sendshortcut,F5,class:com.obsproject.Studio"))
hl.bind(mainMod .. " + F6", hl.dsp.exec_cmd("hyprctl dispatch sendshortcut,F6,class:com.obsproject.Studio"))

local workspaces = {
    { key = "1", id = 1 },
    { key = "2", id = 2 },
    { key = "3", id = 3 },
    { key = "4", id = 4 },
    { key = "5", id = 5 },
    { key = "6", id = 6 },
    { key = "7", id = 7 },
    { key = "8", id = 8 },
    { key = "9", id = 9 },
    { key = "0", id = 10 },
    { key = "g", id = 99 },
    { key = "c", id = 98 },
}

for _, ws in pairs(workspaces) do
    hl.bind(mainMod .. " + " .. ws.key, hl.dsp.focus({ workspace = ws.id }))
    hl.bind(mainMod .. " + SHIFT" .. " + " .. ws["key"], hl.dsp.window.move({ workspace = ws["id"], follow = true }))
end

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special("obsidian"))

-- Mouse
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Special keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

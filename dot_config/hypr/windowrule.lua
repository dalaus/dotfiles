-- Ignore maximize requests from apps. You'll probably like this.

hl.window_rule({
    name = "suppress-maximize-events",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- Make flameshot pinned windows float

hl.window_rule({
    name = "float-flameshot-pins",
    match = {
        title = "flameshot-pin",
    },
    float = true,
})

-- Fix some dragging issues with XWayland

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

-- Make naps2 float by default

hl.window_rule({
    name = "float-naps2",
    match = {
        class = "naps2",
    },
    float = true,
})

-- Disable screen sharing for KeePassXC (security)

hl.window_rule({
    name = "no-screen-share-keepassxc",
    match = {
        class = "org.keepassxc.KeePassXC",
    },
    no_screen_share = true,
})

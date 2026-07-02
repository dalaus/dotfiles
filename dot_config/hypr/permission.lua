hl.config({
    ecosystem = {
        enforce_permissions = 1,
    },
})

hl.permission("/usr/bin/grim", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")

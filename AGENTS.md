# AGENTS.md - Dotfiles Repository Guidelines

Guidelines for agents working on this chezmoi-managed Linux desktop setup.
Stack: Hyprland (Lua config API), Waybar, Ghostty, Fuzzel, Flameshot, oh-my-posh, zsh.

## Overview

- Source of truth lives in this repo; deploy with `chezmoi apply`.
- Hyprland is configured in **Lua** via the `hl` API (not classic `.conf` hyprlang).
- Entry point: `dot_config/hypr/hyprland.lua` — it `require`s modular files.
- `AGENTS.md` and `apply_all.sh` are listed in `.chezmoiignore` (repo-only, not deployed).

## Build / Lint / Test Commands

### Applying Configurations
```bash
# Apply all managed files
chezmoi apply

# Apply one target path (deployed path, not source path)
chezmoi apply ~/.config/hypr/hyprland.lua

# Preview changes without writing
chezmoi apply --dry-run
chezmoi diff

# Status of source vs destination
chezmoi status
```

### Quick apply + reload helper
```bash
# Applies configs and soft-reloads Waybar
./apply_all.sh
```

### Validation and Testing
```bash
# Hyprland: reload config (fails on syntax/runtime config errors)
hyprctl reload

# Format Hyprland Lua with stylua (settings in stylua.toml)
stylua dot_config/hypr/*.lua

# Waybar: soft reload
killall -SIGUSR2 waybar

# Waybar JSON syntax
python3 -m json.tool dot_config/waybar/config

# Zsh syntax
zsh -n dot_zshrc

# oh-my-posh theme JSON
python3 -m json.tool \
  dot_config/oh-my-posh/themes/onehalf.minimal.omp.json

# INI-style configs (fuzzel, flameshot) — no dedicated linter;
# inspect after apply / restart the app
```

### Repository Management
```bash
# Track a new file from the live system
chezmoi add ~/.config/some/new/file.conf

# Edit a managed file
chezmoi edit ~/.config/hypr/hyprland.lua

# Re-add after manual destination edits
chezmoi re-add

chezmoi status
```

## Code Style Guidelines

### Shell (`dot_zshrc`, scripts)
- 4 spaces for indentation
- Group related exports and settings
- Descriptive names; prefer clear one-liners for simple helpers
- End files with a newline
- Keep lines under ~80–100 characters when practical

### Hyprland Lua (`dot_config/hypr/*.lua`)
- **Format**: stylua — 4 spaces (`stylua.toml`)
- **API**: use the global `hl` table (`hl.bind`, `hl.config`, `hl.env`,
  `hl.exec_cmd`, `hl.on`, `hl.window_rule`, `hl.permission`, `hl.layout`, …)
- **Modules**: one concern per file; wire them from `hyprland.lua` via `require`
- Do **not** convert modules back to classic hyprlang `.conf` unless requested
- Group related binds, rules, and config tables
- Prefer variables for repeated values (e.g. `mainMod`)
- RGBA / color strings consistent with existing style.lua
- Name window rules descriptively (`name = "float-flameshot-pins"`)
- Custom layouts live in `experiments.lua` and register via `hl.layout.register`
- LuaLS stubs: `.luarc.json` points at `/usr/share/hypr/stubs`
- Keep `hyprsunset.conf` as classic conf (not Lua) unless the project migrates it

### Waybar JSON
- 4 spaces
- Readable modular structure; camelCase keys as used by Waybar
- Validate with `python3 -m json.tool` before committing

### Waybar CSS
- 4 spaces
- Prefer `@define-color` / custom properties for shared colors
- Keep specificity low; group related selectors
- Match existing palette (background / text tokens already defined)

### Other app configs
- **Ghostty** (`ghostty/config`): key = value, one setting per line
- **Fuzzel** / **Flameshot** (`.ini`): section headers, keep existing tone
- **oh-my-posh** (JSON theme): keep `$schema` and palette tokens consistent

### General
- UTF-8, trailing newline
- Comment non-obvious behavior (esp. security permissions and window rules)
- Principle of least surprise; test after changes
- Do not store secrets in this repo

## File Organization
```
.
├── AGENTS.md                 # This file (chezmoi-ignored)
├── apply_all.sh              # chezmoi apply + waybar reload (ignored)
├── .chezmoiignore
├── dot_zshrc                 # → ~/.zshrc
├── dot_config/               # → ~/.config/
│   ├── hypr/
│   │   ├── hyprland.lua      # Entry: requires modules below
│   │   ├── autostart.lua
│   │   ├── bind.lua
│   │   ├── experiments.lua   # Custom Lua layouts (grid, circle)
│   │   ├── input_output.lua
│   │   ├── layout.lua
│   │   ├── permission.lua
│   │   ├── style.lua
│   │   ├── windowrule.lua
│   │   ├── hyprsunset.conf
│   │   ├── stylua.toml
│   │   └── .luarc.json       # source: dot_luarc.json
│   ├── waybar/
│   │   ├── config
│   │   └── style.css
│   ├── ghostty/config
│   ├── fuzzel/fuzzel.ini
│   ├── flameshot/flameshot.ini
│   └── oh-my-posh/themes/
│       └── onehalf.minimal.omp.json
└── private_dot_local/        # → ~/.local/ (private mode on dir)
    └── share/icons/
        └── phinger-hyprcursors-light/
```

### Hyprland module roles
| File | Role |
|------|------|
| `hyprland.lua` | Entry point; `require` modules; global env fixes |
| `autostart.lua` | Startup apps on `hyprland.start` |
| `bind.lua` | Keybinds (terminal, launcher, workspaces, …) |
| `style.lua` | Gaps, borders, decoration, cursor env |
| `layout.lua` | Default layout / scrolling settings |
| `input_output.lua` | Monitors and keyboard/mouse input |
| `permission.lua` | Ecosystem permissions (screencopy, …) |
| `windowrule.lua` | Window rules |
| `experiments.lua` | Experimental custom layouts + workspace rules |

## Naming Conventions (chezmoi)
- `dot_*` → files/dirs under `$HOME` with leading `.` stripped of the prefix
- `private_*` → private destination permissions
- Prefer lowercase with underscores for new managed source names
- Follow existing paths under `dot_config/`

## Error Handling
- Validate Lua/JSON/zsh before apply when possible
- Prefer `chezmoi apply --dry-run` / `chezmoi diff` before real apply
- After Hyprland changes: `hyprctl reload`
- After Waybar changes: `killall -SIGUSR2 waybar` or `./apply_all.sh`
- Keep comments for known workarounds (e.g. WebKit compositing env)

## Security Considerations
- Do not commit tokens, passwords, or private keys
- Be careful with `permission.lua` and screencopy allow-lists
- Window rules that block screen share (e.g. KeePassXC) are intentional
- Config files: typically 644; scripts: 755
- `private_dot_local` exists for stricter local data (icons, etc.)

## Testing Approach
1. Edit source files in this repo
2. Run syntax/format checks (`stylua`, `json.tool`, `zsh -n`)
3. `chezmoi apply --dry-run` / `chezmoi diff`
4. `chezmoi apply` (or `./apply_all.sh`)
5. `hyprctl reload` and verify binds/windows/autostart
6. Spot-check Waybar, Fuzzel, Ghostty, Flameshot as needed

## Commit Guidelines

### Message format (Conventional Commits)
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`

**Examples:**
```
feat(hypr): add custom circle layout workspace
fix(waybar): correct language module format
docs: update AGENTS.md for Lua Hyprland config
style(hypr): format modules with stylua
chore: add apply_all helper script
```

### Best practices
- Imperative mood, first line ≤50 chars, no trailing period
- Explain why when non-obvious
- Atomic, focused commits; test before committing

## Environment Variables
- Prefer XDG paths (`~/.config`, `~/.local`)
- Shell exports live in `dot_zshrc`; session/cursor env often in `style.lua` via `hl.env`
- Use `UPPER_CASE` for env vars

## Dependencies (runtime stack)
Documented for agents; install via system packages as needed:

| Component | Role |
|-----------|------|
| Hyprland (+ Lua config / stubs) | WM; configs under `dot_config/hypr` |
| hyprsunset | Night light (`hyprsunset.conf`) |
| Waybar | Status bar |
| Ghostty | Terminal (`SUPER+Return`) |
| Fuzzel | App launcher (`SUPER+D`) |
| Flameshot | Screenshots |
| dunst | Notifications (autostart) |
| awww | Wallpaper daemon (autostart) |
| nm-applet | Network tray (autostart) |
| hyprpolkitagent | Polkit agent (autostart) |
| oh-my-posh | Zsh prompt theme |
| zsh-autosuggestions / zsh-syntax-highlighting | Shell plugins |
| phinger cursors | XCURSOR / HYPRCURSOR theme |
| stylua | Optional: format Hyprland Lua |
| chezmoi | Dotfile deployment |

## Agent Notes
- When editing Hyprland, prefer the modular Lua files over stuffing everything into `hyprland.lua`.
- Binds for apps should match real binaries used in this setup (ghostty, fuzzel, flameshot, dolphin).
- Do not “fix” Lua back to `.conf` style; the project intentionally uses the Lua API.
- Cursor assets under `private_dot_local/share/icons/` are bulky binary-ish assets — avoid drive-by reformatting.
- Color accent in UI configs is often `#d32450` / `rgba(d32450…)`; keep palette consistent unless redesigning.
)

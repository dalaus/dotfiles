# AGENTS.md - Dotfiles Repository Guidelines

This document provides guidelines for agentic coding agents working on this dotfiles repository managed with chezmoi. The repository contains Linux desktop configuration files for Hyprland, Waybar, and shell environments.

## Build/Lint/Test Commands

### Applying Configurations
```bash
# Apply all dotfiles to the current system
chezmoi apply

# Apply specific file
chezmoi apply ~/.config/hypr/hyprland.conf

# Dry run to see what would be changed
chezmoi apply --dry-run

# Check for differences between source and target
chezmoi diff
```

### Validation and Testing
```bash
# Validate Hyprland configuration syntax
hyprctl reload  # This will fail if config has syntax errors

# Reload Waybar configuration
killall -SIGUSR2 waybar

# Check JSON syntax for Waybar config
python3 -m json.tool dot_config/waybar/config

# Test shell configuration syntax
zsh -n dot_zshrc

# Validate CSS syntax for Waybar styles
# Note: No dedicated CSS validator, but can use browser dev tools or online validators

# Test hyprsunset configuration
hyprsunset --help  # Check if daemon is running properly
```

### Repository Management
```bash
# Add new file to chezmoi management
chezmoi add ~/.config/some/new/file.conf

# Edit managed file
chezmoi edit ~/.config/hypr/hyprland.conf

# Update repository with changes
chezmoi re-add

# Check repository status
chezmoi status
```

## Code Style Guidelines

### Shell Scripts (.zshrc, shell scripts)
- Use 4 spaces for indentation
- Include comments for complex configurations
- Group related exports and settings together
- Use descriptive variable names
- Follow POSIX shell conventions where possible
- End files with a newline
- Keep lines under 80 characters when possible

### Hyprland Configuration
- Use consistent indentation (4 spaces)
- Group related settings in logical sections
- Use descriptive comments for complex configurations
- Follow the official Hyprland documentation conventions
- Use variables for repeated values (e.g., `$terminal`, `$mainMod`)
- Keep animation and decoration settings organized
- Use RGBA color format consistently
- Group keybindings by functionality

### JSON Configuration Files (Waybar)
- Use 4 spaces for indentation
- Keep objects and arrays properly formatted
- Use consistent naming conventions (camelCase)
- Include comments where helpful (JSON5 style when supported)
- Keep configuration modular and readable
- Validate JSON syntax before committing

### CSS Files (Waybar styles)
- Use 4 spaces for indentation
- Group related selectors together
- Use CSS custom properties (variables) for colors and common values
- Follow BEM-like naming conventions for classes
- Include comments for complex selectors or properties
- Keep specificity low and organized
- Use consistent color formats (hex, rgb, or CSS custom properties)

### General Guidelines
- All files should end with a newline
- Use UTF-8 encoding
- Keep line lengths reasonable (<100 characters when possible)
- Include comments for non-obvious configurations
- Follow the principle of least surprise
- Test configurations after changes
- Use version control appropriately for configuration changes

## File Organization
```
dot_config/           # User configuration files
├── hypr/            # Hyprland window manager
│   ├── autostart.conf
│   ├── bind.conf
│   ├── hyprland.conf
│   ├── hyprsunset.conf
│   ├── io.conf
│   ├── permission.conf
│   ├── style.conf
│   └── windowrule.conf
└── waybar/          # Status bar
    ├── config       # JSON configuration
    └── style.css    # CSS styling

dot_zshrc            # Zsh shell configuration
```

## Naming Conventions
- Use lowercase with underscores for file names (chezmoi convention)
- Prefix with `dot_` for files that go in home directory
- Use descriptive names that indicate purpose
- Follow existing patterns in the repository

## Error Handling
- Test configurations after making changes
- Use `chezmoi apply --dry-run` before applying changes
- Validate syntax before committing
- Keep backups of working configurations
- Document known issues or workarounds in comments

## Security Considerations
- Be careful with executable permissions on scripts
- Avoid storing sensitive information in dotfiles
- Use appropriate file permissions (644 for configs, 755 for scripts)
- Review changes before applying to production systems

## Testing Approach
1. Make changes to source files
2. Validate syntax using appropriate tools
3. Apply changes with `chezmoi apply --dry-run`
4. Test functionality in a safe environment
5. Apply to production system
6. Verify everything works as expected

## Commit Guidelines

### Message Format
Use the Conventional Commits specification for consistent commit messages:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect code meaning (formatting, etc.)
- `refactor`: Code changes that neither fix bugs nor add features
- `perf`: Performance improvements
- `test`: Adding or correcting tests
- `chore`: Build process or auxiliary tool changes

**Examples for dotfiles:**
```
feat: add hyprland window manager config
fix: correct waybar CSS styling
docs: update AGENTS.md guidelines
style: format zshrc with consistent indentation
chore: reorganize zsh aliases
```

### Alternative Patterns
- **Imperative mood**: "Add feature" not "Added feature"
- **Category prefixes**: `[UI] Add dark mode`, `[API] Fix endpoint`
- **Issue references**: `Fix login bug (#123)`

### Best Practices
- Keep first line under 50 characters
- Start with present tense verbs
- Capitalize first word, no trailing period
- Explain what and why, not just what
- Reference issues/PRs when applicable
- Group related changes together
- Test before committing
- Keep commits focused and atomic

## Environment Variables
- Use XDG Base Directory specification where possible
- Keep environment variables organized in logical groups
- Document the purpose of custom environment variables
- Use consistent naming (UPPER_CASE with underscores)

## Dependencies
- Document system dependencies required for configurations
- Keep track of package requirements
- Note version requirements where applicable
- Consider cross-platform compatibility when possible

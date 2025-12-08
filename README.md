# dotfiles

Minimal macOS dotfiles for quick new machine setup.

## Quick Start

On a new Mac, run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/noahbaxter/dotfiles/master/bootstrap.sh)
```

This will:
1. Generate SSH key (if needed) and prompt you to add it to GitHub
2. Install Xcode Command Line Tools
3. Install Homebrew
4. Install all applications and CLI tools
5. Clone this repo to `~/Code/personal/dotfiles` (if needed)
6. Symlink dotfiles to your home directory
7. Apply macOS system defaults

## What's Included

### Applications
- **Dev**: VS Code, iTerm2, Claude Code
- **Browsers**: Firefox
- **Utilities**: Dropbox, Rectangle, Bitwarden, Karabiner-Elements
- **Work**: Slack, Microsoft Teams
- **Music**: Ableton Live Suite, Audacity, Reaper

### CLI Tools
- git, wget, tree, starship

### Dotfiles
- `.zshrc` - Minimal zsh config with basic aliases
- `.gitconfig` - Git configuration with useful aliases
- `starship.toml` - Clean shell prompt
- `karabiner.json` - Mouse button shortcuts for desktop navigation
- `iterm2` preferences

### System Defaults
The `install/macos-defaults.sh` script configures:
- Finder (show hidden files, extensions, path bar)
- Dock (auto-hide, no animations)
- Keyboard/Mouse (fast repeat, disable natural scroll)
- Disable Siri and Apple Intelligence
- And many more power user tweaks

## Manual Installation

If you already have the repo cloned, you can run individual steps:

```bash
# Just install Homebrew and apps
./install/homebrew.sh

# Just install dotfiles (symlinks)
./install/symlinks.sh

# Just apply macOS defaults
./install/macos-defaults.sh

# Or run everything
./bootstrap.sh
```

## Post-Setup

After running bootstrap.sh, complete these manual steps:

1. **iTerm2** - Quit iTerm2, then run:
   ```bash
   ./install/iterm.sh
   ```

2. **Karabiner-Elements**
   - Open Karabiner-Elements and enable the mouse shortcuts rule
   - (Mouse button 3/4/5 with Control+Shift for desktop navigation)

3. **System Changes**
   - Log out and log back in for all macOS system changes to take effect

## Customization

Edit files in this repo, and since they're symlinked, changes are immediately tracked by git.

## Structure

```
├── bootstrap.sh               # Main entrypoint (runs all steps)
├── .zshrc                     # Shell configuration
├── .gitconfig                 # Git configuration
├── starship.toml              # Shell prompt config
├── install/
│   ├── homebrew.sh           # Installs Homebrew and applications
│   ├── symlinks.sh           # Creates symlinks for dotfiles
│   ├── iterm.sh              # Configures iTerm2 preferences
│   └── macos-defaults.sh     # Applies macOS system defaults
└── config/
    ├── karabiner/
    │   └── karabiner.json     # Keyboard/mouse remapping
    └── iterm2/
        └── com.googlecode.iterm2.plist  # iTerm2 preferences
```

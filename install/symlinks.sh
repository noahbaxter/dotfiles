#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

echo "Installing dotfiles from $DOTFILES_DIR"
echo ""

# Function to backup and symlink a file
link_file() {
  local src=$1
  local dest=$2

  if [ ! -f "$src" ]; then
    echo "  ⚠ Skipping $dest (source not found)"
    return
  fi

  if [ -L "$dest" ]; then
    echo "  ✓ $dest already linked"
  elif [ -f "$dest" ]; then
    echo "  ⚠ Backing up existing $dest"
    mv "$dest" "$dest.backup"
    ln -s "$src" "$dest"
    echo "  ✓ Linked $dest"
  else
    ln -s "$src" "$dest"
    echo "  ✓ Linked $dest"
  fi
}

# Function to backup and symlink a directory
link_dir() {
  local src=$1
  local dest=$2

  if [ ! -d "$src" ]; then
    echo "  ⚠ Skipping $dest (source not found)"
    return
  fi

  if [ -L "$dest" ]; then
    echo "  ✓ $dest already linked"
  elif [ -d "$dest" ]; then
    echo "  ⚠ Backing up existing $dest"
    mv "$dest" "$dest.backup"
    ln -s "$src" "$dest"
    echo "  ✓ Linked $dest"
  else
    ln -s "$src" "$dest"
    echo "  ✓ Linked $dest"
  fi
}

echo "Shell Configuration:"
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

echo ""
echo "Git Configuration:"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"

echo ""
echo "Shell Prompt:"
mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

echo ""
echo "Keyboard Configuration:"
mkdir -p "$HOME/.config/karabiner"
link_file "$DOTFILES_DIR/config/karabiner/karabiner.json" "$HOME/.config/karabiner/karabiner.json"

echo ""
echo "iTerm2 Configuration:"
echo "  → Run: ./install/iterm.sh (requires iTerm2 to be closed)"

echo ""
echo "Claude Code:"
mkdir -p "$HOME/.claude"
link_dir "$DOTFILES_DIR/.claude/commands" "$HOME/.claude/commands"
link_dir "$DOTFILES_DIR/.claude/agents" "$HOME/.claude/agents"
link_file "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
link_file "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

echo ""
echo "Claude Code (Work):"
mkdir -p "$HOME/.claude-work"
link_file "$DOTFILES_DIR/.claude/CLAUDE.md" "$HOME/.claude-work/CLAUDE.md"
link_dir "$DOTFILES_DIR/.claude/commands" "$HOME/.claude-work/commands"
link_dir "$DOTFILES_DIR/.claude/agents" "$HOME/.claude-work/agents"
link_file "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude-work/settings.json"

echo ""
echo "Installation complete! ✓"

#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
ITERM_CONFIG_DIR="$DOTFILES_DIR/config/iterm2"

echo "Configuring iTerm2 to load preferences from dotfiles..."

# Check if iTerm is running
if pgrep -x "iTerm2" > /dev/null; then
  echo "  ⚠ iTerm2 is running. Quit iTerm2, then run this script again."
  echo "  (Settings won't apply until iTerm2 restarts)"
  exit 1
fi

# Point iTerm2 to load preferences from dotfiles
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$ITERM_CONFIG_DIR"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Auto-save changes back to the custom folder on quit
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2

echo "  ✓ iTerm2 will load/save preferences from: $ITERM_CONFIG_DIR"
echo ""
echo "Done! Open iTerm2 to apply settings."

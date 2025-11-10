#!/bin/bash
set -e

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   macOS Bootstrap Setup                ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Detect if we're running locally or from curl
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
IS_LOCAL_RUN=false

if [ -f "$SCRIPT_DIR/bootstrap.sh" ]; then
  IS_LOCAL_RUN=true
  echo "Running from local dotfiles repository"
else
  echo "Running from remote (curl)"
fi

echo ""

# Step 1: Install Homebrew and applications
echo "Step 1: Installing Homebrew and applications..."
echo ""
if [ "$IS_LOCAL_RUN" = true ]; then
  bash "$SCRIPT_DIR/install/homebrew.sh"
else
  # For remote execution, we need to download and run homebrew.sh
  bash <(curl -fsSL https://raw.githubusercontent.com/noahbaxter/dotfiles/master/install/homebrew.sh)
fi

# Step 2: Ensure dotfiles are cloned to the right place
echo ""
echo "Step 2: Ensuring dotfiles repository is in the right place..."
if [ ! -d ~/Code/personal/dotfiles ]; then
  echo "Cloning dotfiles repository..."
  mkdir -p ~/Code/personal
  cd ~/Code/personal && git clone https://github.com/noahbaxter/dotfiles.git
  DOTFILES_DIR="$HOME/Code/personal/dotfiles"
elif [ "$IS_LOCAL_RUN" = true ] && [ "$SCRIPT_DIR" != "$HOME/Code/personal/dotfiles" ]; then
  echo "Warning: Running from $SCRIPT_DIR but dotfiles are at ~/Code/personal/dotfiles"
  echo "Using ~/Code/personal/dotfiles for consistency"
  DOTFILES_DIR="$HOME/Code/personal/dotfiles"
else
  DOTFILES_DIR="${SCRIPT_DIR:-$HOME/Code/personal/dotfiles}"
fi

# Step 3: Install dotfiles (symlinks)
echo ""
echo "Step 3: Installing dotfiles (symlinks)..."
bash "$DOTFILES_DIR/install/symlinks.sh"

# Step 4: Apply macOS defaults
echo ""
echo "Step 4: Applying macOS system defaults..."
bash "$DOTFILES_DIR/install/macos-defaults.sh"

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   Setup Complete! 🎉                   ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "Next steps:"
echo "  - Open Karabiner-Elements and enable the mouse shortcuts rule"
echo "  - Log out and back in for all system changes to take effect"
echo ""

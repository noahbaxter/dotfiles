#!/bin/bash
set -e

echo "Installing Homebrew and applications..."
echo ""

# SSH Key
if [ ! -f ~/.ssh/id_rsa ]; then
  echo "Creating an SSH key for you..."
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -f ~/.ssh/id_rsa -N ""
  echo ""
  echo "SSH key created! Add this public key to GitHub:"
  echo "https://github.com/settings/keys"
  echo ""
  cat ~/.ssh/id_rsa.pub
  echo ""
  read -p "Press [Enter] after adding the key to GitHub..."
else
  echo "SSH key already exists, skipping..."
fi

echo ""
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
else
  echo "Xcode Command Line Tools already installed, skipping..."
fi

# Install homebrew if we don't have it
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

# Create Code directories
echo ""
echo "Creating Code directories..."
mkdir -p ~/Code/work
mkdir -p ~/Code/personal
mkdir -p ~/Code/misc

# Dev apps
echo ""
echo "Installing dev applications..."
brew install --cask visual-studio-code
brew install --cask iterm2
brew install --cask claude-code

# Normal Apps
echo ""
echo "Installing applications..."
brew install --cask dropbox
brew install --cask firefox
brew install --cask claude
brew install --cask karabiner-elements
brew install --cask stolendata-mpv

# Settings Apps
echo ""
echo "Installing utility applications..."
brew install --cask rectangle
brew install --cask bitwarden

# Work
echo ""
echo "Installing work applications..."
brew install --cask microsoft-teams
brew install --cask slack

# Music
echo ""
echo "Installing music applications..."
brew install --cask ableton-live-suite
brew install --cask audacity
brew install --cask reaper

# CLI Tools
echo ""
echo "Installing CLI tools..."
brew install wget
brew install tree
brew install starship
brew install git

# Git Config
echo ""
echo "Configuring Git..."
git config --global user.name "Noah Baxter"
git config --global user.email noahbaxt@gmail.com

echo ""
echo "Homebrew installation complete! ✓"

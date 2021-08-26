#!/bin/sh

# Copy files over.
cp ./.zshrc ~/
cp ./.gitconfig ~/

echo "Open a new terminal!"

# Update all brew packages, and cleanup old versions.
brew upgrade
brew cleanup

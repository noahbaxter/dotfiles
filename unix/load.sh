#!/bin/sh

# Copy files over.
cp ./.zshrc ~/
cp ./.bash_aliases ~/
cp ./.bash_functions ~/
cp ./.bash_profile ~/
cp ./.bash_prompt ~/
cp ./.bashrc ~/
cp ./.gitconfig ~/

# Refresh the settings.
. ~/.zshrc
. ~/.bash_aliases
. ~/.bash_functions
. ~/.bash_profile
. ~/.bash_prompt
. ~/.bashrc
# . ~/.gitconfig

# Update all brew packages, and cleanup old versions.
brew upgrade
brew cleanup

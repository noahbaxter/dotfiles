#!/bin/sh

# Copy files over.
cp ./.bash_aliases ~/
cp ./.bash_prompt ~/
cp ./.bash_profile ~/
cp ./.bash_functions ~/
cp ./.gitconfig ~/

# Refresh the settings.
. ~/.bash_aliases
. ~/.bash_prompt
. ~/.bash_profile
. ~/.bash_functions
# . ~/.gitconfig

# Update all brew packages, and cleanup old versions.
brew upgrade
brew cleanup

#!/bin/sh

# Copy files over.
cp ./.bash_aliases ~/
cp ./.bash_functions ~/
cp ./.bash_profile ~/
cp ./.bash_prompt ~/
cp ./.gitconfig ~/

# Refresh the settings.
. ~/.bash_aliases
. ~/.bash_functions
. ~/.bash_profile
. ~/.bash_prompt
# . ~/.gitconfig

# Update all brew packages, and cleanup old versions.
brew upgrade
brew cleanup

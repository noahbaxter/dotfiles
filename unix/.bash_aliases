#!/usr/bin/env bash

alias l='ls -l'
alias cl='clear'

# fast directory navigation
alias ~="cd ~"
alias Code="cd ~/Code"
alias Subpac="cd ~/Code/work/Subpac"

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

# if repos are cloned, link them
if [ -d ~/Code/work/Subpac/autopoc ] ; then
  alias autopoc="cd ~/Code/work/Subpac/autopoc"
fi
if [ -d ~/Code/work/Subpac/autopoc-ui ] ; then
  alias autopoc-ui="cd ~/Code/work/Subpac/autopoc-ui"
fi
if [ -d ~/Code/misc/dotfiles ] ; then
  alias dotfiles="cd ~/Code/misc/dotfiles"
fi


# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Public IP addresses
alias ip="curl -v https://ipinfo.io/ip"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Development
alias makeenv="python3 -m venv env"
alias makeenv2="virtualenv env"

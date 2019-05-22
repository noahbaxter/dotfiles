#!/usr/bin/env bash

alias l='ls -l'
alias cl='clear'

# fast directory navigation
alias ~="cd ~"
export code=$HOME/Code
export subpac=$HOME/Code/work/Subpac

export applications=/Applications
export desktop=$HOME/Desktop
export downloads=$HOME/Downloads

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

# if repos are cloned, link them
if [ -d ~/Code/work/Subpac/autopoc ] ; then
  export autopoc=$HOME/Code/work/Subpac/autopoc
fi
if [ -d ~/Code/work/Subpac/autopoc-ui ] ; then
  export autopocui=$HOME/Code/work/Subpac/autopoc-ui
fi
if [ -d ~/Code/misc/dotfiles ] ; then
  export dotfiles=$HOME/Code/misc/dotfiles
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

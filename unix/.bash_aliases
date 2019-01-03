#!/usr/bin/env bash

alias l='ls -l'
alias cl='clear'

# Easier navigation: .., ~, code directory.
alias ~="cd ~"
alias code="cd ~/Code"
# alias code="cd /Volumes/nahiri/Code"

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."

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

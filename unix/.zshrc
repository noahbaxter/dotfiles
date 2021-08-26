eval "$(/opt/homebrew/bin/starship init zsh)"

if [[ `uname -m` == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# A L I A S E S

alias l='ls -l'
alias cl='clear'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Public IP addresses
alias ip="curl -v https://ipinfo.io/ip"

# Show/hide hidden files in Finder
alias showhf="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hidehf="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# export subpac=$HOME/Code/work/Subpac

# export applications=/Applications
# export desktop=$HOME/Desktop
# export downloads=$HOME/Downloads

# # if repos are cloned, link them
# if [ -d ~/Code/work/Subpac/flow ] ; then
#   export flow=$HOME/Code/work/Subpac/flow
# fi
# if [ -d ~/Code/work/Subpac/flow-ui ] ; then
#   export flowui=$HOME/Code/work/Subpac/flow-ui
# fi
# if [ -d ~/Code/personal/dotfiles ] ; then
#   export dotfiles=$HOME/Code/misc/dotfiles
# fi

# F U N C T I O N S

# never show me the .DS_store EVER
function ll { ls -lA | grep -v .DS_Store;}
function la { ls -A | grep -v .DS_Store;}

# networking shortcuts
function mac_spoof { sudo macchanger -r en0;}
function mac_unspoof { sudo macchanger -m 60:03:08:93:e4:d0 en0;}

# disables screensaver/sleep until stopped
function caffeine {
  idleTime="$(defaults -currentHost read com.apple.screensaver idleTime)"
  defaults -currentHost write com.apple.screensaver idleTime 0
  trap "defaults -currentHost write com.apple.screensaver idleTime $idleTime; unset idleTime" RETURN
  caffeinate
}

function git_open {
  open `git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'`| head -n1
}

function mpv_gl {
  mpv --gapless-audio=yes --loop "$1"
}

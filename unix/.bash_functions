#!/usr/bin/env bash

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

# Automated Git
# function git_rmlocal {
#   git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d
# }

function git_open {
  open `git remote -v | grep fetch | awk '{print $2}' | sed 's/git@/http:\/\//' | sed 's/com:/com\//'`| head -n1
}

function mpv_gl {
  mpv --gapless-audio=yes --loop "$1"
}

function work {
  open -a "Atom"
  open -a "Slack"

  if [ -f ~/Code/misc/dotfiles/unix/ascript/work.applescript ] ; then
    osascript ~/Code/misc/dotfiles/unix/ascript/work.applescript
  fi
}

function unwork {
  osascript -e 'quit app "Atom"'
  pkill -9 -f 'Atom' 2>/dev/null
  osascript -e 'quit app "Slack"'
  osascript -e 'tell application "Finder" to close windows'
  osascript -e 'tell application "iTerm2"' -e 'set mainID to id of front window' -e 'close (every window whose id ≠ mainID)' -e 'end tell'

  pkill -f 'ng serve' 2>/dev/null
  pkill -f 'php' 2>/dev/null
  pkill -f 'autopoc' 2>/dev/null

}

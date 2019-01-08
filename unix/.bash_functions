#!/usr/bin/env bash

# never show me the .DS_store EVER
function ll { ls -lA | grep -v .DS_Store;}
function la { ls -A | grep -v .DS_Store;}

# networking shortcuts
function mac_spoof { sudo macchanger -r en0;}
function mac_unspoof { sudo macchanger -m 60:03:08:93:e4:d0 en0;}

# disables screensaver/sleep until stopped
function caffeinate+ {
  idleTime="$(defaults -currentHost read com.apple.screensaver idleTime)"
  defaults -currentHost write com.apple.screensaver idleTime 0
  trap "defaults -currentHost write com.apple.screensaver idleTime $idleTime; unset idleTime" RETURN
  caffeinate
}

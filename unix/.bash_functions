#!/usr/bin/env bash

# never show me the .DS_store EVER
function ll { ls -lA | grep -v .DS_Store;}
function la { ls -A | grep -v .DS_Store;}

# networking shortcuts
function mac_spoof { sudo macchanger -r en0;}
function mac_unspoof { sudo macchanger -m 60:03:08:93:e4:d0 en0;}

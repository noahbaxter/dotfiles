# Brew stuff
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap cask room/cask

# Dev stuff
mkdir /Users/$(whoami)/Code
mkdir /Users/$(whoami)/Code/personal
mkdir /Users/$(whoami)/Code/misc
mkdir /Users/$(whoami)/Code/work

git clone https://github.com/noahbaxter/dotfiles.git /Users/$(whoami)/Code/misc/dotfiles
cd /Users/$(whoami)/Code/misc/dotfiles/unix && ./load.sh

# System Preferences


# Software
brew cask install atom
brew cask install qbittorrent

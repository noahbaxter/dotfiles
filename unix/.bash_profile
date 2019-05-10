#!/usr/bin/env bash
#THANK YOU DEEPIO !!@!!!!! :D

# Add ssh keys if not there
if ! ssh-add -l >/dev/null; then
	ssh-add -K "$HOME/Code/work/Subpac/key.txt"
fi

# Add `~/bin` to the `$PATH`
ADD_PATH="$HOME/bin:"
ADD_PATH+="$HOME/Code/misc/dotfiles/unix/commands/git-rmlocal:"
export PATH="$ADD_PATH$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,bash_aliases,bash_functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Add tab completion for git
source /opt/local/etc/bash_completion.d/git-completion.bash

export CLICOLOR=1
export TERM=xterm-256color

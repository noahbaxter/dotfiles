#!/usr/bin/env bash
#THANK YOU DEEPIO !!@!!!!! :D

# Make vars cdable
shopt -s cdable_vars

# Add ssh keys if not there
if ! ssh-add -l >/dev/null; then
	ssh-add -K "$HOME/.ssh/id_ed25519"
fi

# Add `~/bin` to the `$PATH`
ADD_PATH="$HOME/bin:"
ADD_PATH+="$HOME/Code/misc/dotfiles/unix/commands/git-rmlocal:"
export PATH="$ADD_PATH$PATH"
# brew python specifc
export PATH=/usr/local/opt/python/libexec/bin:/usr/local/bin:/usr/local/sbin:$PATH

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
if [ -f ~/.git-completion.bash ]; then
  	. ~/.git-completion.bash
else
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
	. ~/.git-completion.bash
fi

export CLICOLOR=1
export TERM=xterm-256color
eval "$(/opt/homebrew/bin/starship init zsh)"

if [[ `uname -m` == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Aliases
alias l='ls -lAhF'
alias ll='ls -lAhFS'
alias la='ls -A'
alias 'l@'='ls -lAhF@'
alias cl='clear'
alias degate='xattr -d com.apple.quarantine'
alias claude-work='CLAUDE_CONFIG_DIR=~/.claude-work claude'
# Added by Antigravity
export PATH="/Users/noahbaxter/.antigravity/antigravity/bin:$PATH"

# Custom scripts in dotfiles
export PATH="$HOME/Code/personal/dotfiles/bin:$PATH"

# Source shell functions
for f in "$HOME/Code/personal/dotfiles/functions"/*; do
    [[ -f "$f" ]] && source "$f"
done

# Created by `pipx` on 2025-11-22 07:11:18
export PATH="$PATH:/Users/noahbaxter/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

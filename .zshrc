eval "$(/opt/homebrew/bin/starship init zsh)"

if [[ `uname -m` == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Aliases
alias ll='ls -lA'
alias la='ls -A'
alias cl='clear'
# Added by Antigravity
export PATH="/Users/noahbaxter/.antigravity/antigravity/bin:$PATH"

# Custom scripts in dotfiles
export PATH="$HOME/Code/personal/dotfiles/bin:$PATH"

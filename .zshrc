# Starship
eval "$(starship init zsh)"

# Zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls='eza'
alias ll='ls -la'
alias g='git'
alias gpu='git pull'
alias gp='git push'
alias gs='git status -s'
alias gco='git checkout'
alias gc='git commit -m'
alias vim='nvim'
alias brew-up='brew update && brew upgrade -y && brew cleanup'

# Git completion
autoload -Uz compinit && compinit

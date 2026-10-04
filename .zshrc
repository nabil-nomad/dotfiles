# Agents (Claude Code, Codex, OpenCode) get a plain zsh: no aliases, zoxide cd, or plugins
[[ -n "$CLAUDECODE$CODEX_THREAD_ID$OPENCODE" ]] && return

# Editor
export EDITOR=nvim
export VISUAL=nvim

# History
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# Completion
autoload -Uz compinit && compinit

# Starship, Zoxide, Fzf
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
source <(fzf --zsh)

# Homebrew: skip confirmation prompts
export HOMEBREW_NO_ASK=1

# Aliases
alias ls='eza'
alias ll='eza -la'
alias vim='nvim'
alias g='git'
alias gpu='git pull'
alias gp='git push'
alias gs='git status -s'
alias gl='git log --oneline --decorate --graph'
alias gco='git checkout'
alias gc='git commit -m'
alias brew-up='brew update && brew upgrade && brew cleanup'
alias cc='claude --dangerously-skip-permissions'

# Zsh Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

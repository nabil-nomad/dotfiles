#!/bin/bash
# Set up a fresh Mac: Xcode CLT, Homebrew, Brewfile packages, dotfile symlinks, git config.
# Safe to re-run. Existing dotfiles are backed up to ~/.bkp/dotfiles/<timestamp>/.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.bkp/dotfiles/$(date +%Y%m%d-%H%M%S)"

# Paths relative to $HOME, symlinked from the repo
DOTFILES=(
  .zshrc
  .zprofile
  .vimrc
  .pip/pip.conf
  .config/tmux
)

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }

# --- Xcode Command Line Tools ---
if ! xcode-select -p &>/dev/null; then
  log "Installing Xcode Command Line Tools"
  xcode-select --install
  until xcode-select -p &>/dev/null; do sleep 5; done
else
  log "Xcode Command Line Tools already installed"
fi

# --- Homebrew ---
if [[ ! -x /opt/homebrew/bin/brew ]]; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  log "Homebrew already installed"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

log "Installing Brewfile packages"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- Dotfiles ---
log "Linking dotfiles"
for f in "${DOTFILES[@]}"; do
  src="$DOTFILES_DIR/$f"
  dest="$HOME/$f"
  [[ "$(readlink "$dest" 2>/dev/null)" == "$src" ]] && continue
  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "$f")"
    mv "$dest" "$BACKUP_DIR/$f"
    echo "backed up ~/$f"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "linked ~/$f"
done

# --- Git ---
log "Configuring git"
git config --global user.name "nabil-nomad"
git config --global user.email "nabilamirkhalil@proton.me"
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

log "Setup complete!"

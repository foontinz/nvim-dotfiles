#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"

if ! command -v zsh >/dev/null 2>&1; then
    brew install zsh
fi

command -v zsh >/dev/null 2>&1 || {
    echo "Zsh installation succeeded but zsh is unavailable in PATH" >&2
    exit 1
}

if [[ ! -d "$OH_MY_ZSH_DIR" ]]; then
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
        "" --unattended --keep-zshrc
fi

[[ -f "$OH_MY_ZSH_DIR/oh-my-zsh.sh" ]] || {
    echo "Oh My Zsh installation is incomplete: $OH_MY_ZSH_DIR" >&2
    exit 1
}

# Install the tracked shell configuration only after Zsh and Oh My Zsh are ready.
cp "$REPO_ROOT/cmd/zsh.bash" "$HOME/.zshrc"
cp "$REPO_ROOT/cmd/zprofile.zsh" "$HOME/.zprofile"

printf 'Zsh ready: %s\n' "$(command -v zsh)"

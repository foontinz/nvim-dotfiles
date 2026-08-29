#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"

# install tmux
brew install tmux

# install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy config
cp "$ROOT_PATH/configs/tmux/tmux.conf" "$HOME/.tmux.conf"

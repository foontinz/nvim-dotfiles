#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# install tmux
brew install tmux

# install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# copy config
cp "$REPO_ROOT/configs/tmux/tmux.conf" "$HOME/.tmux.conf"

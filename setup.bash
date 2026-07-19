#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLERS="$SCRIPT_DIR/cmd/installers"

echo "==> git"
bash "$INSTALLERS/git.bash"

echo "==> ssh"
bash "$INSTALLERS/ssh.bash"

echo "==> rust"
bash "$INSTALLERS/rust.bash"

echo "==> zsh + oh-my-zsh"
bash "$INSTALLERS/zsh.bash"

echo "==> tooling (uv, fzf)"
bash "$INSTALLERS/tooling.bash"

echo "==> nvm + node"
bash "$INSTALLERS/nvm.bash"

echo "==> npm tooling"
bash "$INSTALLERS/npm_tooling.bash"

echo "==> meridian service"
bash "$INSTALLERS/meridian.bash"

echo "==> helix"
bash "$INSTALLERS/helix.bash"

echo "==> neovim"
bash "$INSTALLERS/nvim.bash"

echo "==> tmux"
bash "$INSTALLERS/tmux.bash"

echo "==> ghostty"
bash "$INSTALLERS/ghostty.bash"

echo "==> tb"
bash "$INSTALLERS/tb.bash"

echo "done"

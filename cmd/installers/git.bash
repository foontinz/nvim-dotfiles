#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"

# copy gitconfig
cp "$ROOT_PATH/configs/git/gitconfig" "$HOME/.gitconfig"

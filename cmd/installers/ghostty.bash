#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"
GHOSTTY_CONFIG_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty"

# install ghostty (download from https://ghostty.org or use brew)
# brew install --cask ghostty

# copy config
mkdir -p "$GHOSTTY_CONFIG_PATH"
cp "$ROOT_PATH/configs/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"

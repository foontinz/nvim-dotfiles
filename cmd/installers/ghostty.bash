#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
GHOSTTY_CONFIG_PATH="$HOME/Library/Application Support/com.mitchellh.ghostty"

# install ghostty (download from https://ghostty.org or use brew)
# brew install --cask ghostty

# copy config
mkdir -p "$GHOSTTY_CONFIG_PATH"
cp "$REPO_ROOT/configs/ghostty/config" "$GHOSTTY_CONFIG_PATH/config"

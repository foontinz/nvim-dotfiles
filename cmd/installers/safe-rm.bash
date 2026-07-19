#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"
SOURCE="$ROOT_PATH/cmd/safe-rm"
TARGET="$HOME/.local/bin/rm"

mkdir -p "$HOME/.local/bin"
install -m 755 "$SOURCE" "$TARGET"

echo "safe rm guard installed: $TARGET"

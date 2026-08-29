#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"

# create ssh directory if needed
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# copy config
cp "$ROOT_PATH/configs/ssh/config" "$HOME/.ssh/config"

# generate key if not present
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
fi

#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# create ssh directory if needed
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

# copy config
cp "$REPO_ROOT/configs/ssh/config" "$HOME/.ssh/config"

# generate key if not present
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
fi

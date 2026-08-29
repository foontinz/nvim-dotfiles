#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cp "$REPO_ROOT/configs/git/gitconfig" "$HOME/.gitconfig"

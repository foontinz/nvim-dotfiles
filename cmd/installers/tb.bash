#!/bin/bash
set -euo pipefail

ROOT_PATH="$HOME/dev/personal/dotfiles"

# install tb CLI
brew tap touchbistro/tap
brew install touchbistro/tap/tb

# add registries
tb registry add TouchBistro/tb-registry-example
tb registry add foontinz/touch-bistro-registry

# copy config
cp "$ROOT_PATH/configs/tb/tbrc.yml" "$HOME/.tbrc.yml"

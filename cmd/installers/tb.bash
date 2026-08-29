#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# install tb CLI
brew tap touchbistro/tap
brew install touchbistro/tap/tb

# add registries
tb registry add TouchBistro/tb-registry-example
tb registry add foontinz/touch-bistro-registry

# copy config
cp "$REPO_ROOT/configs/tb/tbrc.yml" "$HOME/.tbrc.yml"

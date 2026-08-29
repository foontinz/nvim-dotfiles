#!/bin/bash
set -euo pipefail

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# install fzf
brew install fzf
brew install direnv
brew install btop

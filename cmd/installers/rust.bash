#!/bin/bash
set -euo pipefail

if ! command -v rustup >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
        | sh -s -- -y --profile minimal
fi

# rustup installs into ~/.cargo/bin, which is not visible to this shell yet.
if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

command -v rustup >/dev/null 2>&1 || {
    echo "rustup installation succeeded but rustup is unavailable in PATH" >&2
    exit 1
}

rustup component add rust-analyzer

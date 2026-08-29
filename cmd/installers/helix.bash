#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
HELIX_VERSION="25.07.1"
HELIX_PATH="$HOME/dev/nightly/helix"
HELIX_CONFIG_PATH="$HOME/.config/helix"
BACKUP_ROOT="$HOME/dev/nightly/helix-backups/$(date +%Y%m%d-%H%M%S)-$$"
STAGING_PATH=""

if [[ -f "$HOME/.cargo/env" ]]; then
    . "$HOME/.cargo/env"
fi

command -v cargo >/dev/null 2>&1 || {
    echo "cargo is required to build Helix" >&2
    exit 1
}

mkdir -p "$HOME/dev/nightly" "$HOME/.config"
STAGING_PATH="$(mktemp -d "$HOME/dev/nightly/.helix-build.XXXXXX")"

cleanup() {
    if [[ -n "$STAGING_PATH" && -d "$STAGING_PATH" ]]; then
        rm -rf "$STAGING_PATH"
    fi
}
trap cleanup EXIT

# Build the pinned release before replacing any existing installation.
git clone --branch "$HELIX_VERSION" --depth 1 \
    https://github.com/helix-editor/helix "$STAGING_PATH"
(
    cd "$STAGING_PATH"
    cargo install --path helix-term --locked
)

mkdir -p "$BACKUP_ROOT"
if [[ -e "$HELIX_PATH" ]]; then
    mv "$HELIX_PATH" "$BACKUP_ROOT/source"
fi
mv "$STAGING_PATH" "$HELIX_PATH"
STAGING_PATH=""

# Preserve the previous configuration before installing the tracked files.
if [[ -e "$HELIX_CONFIG_PATH" ]]; then
    cp -R "$HELIX_CONFIG_PATH" "$BACKUP_ROOT/config"
fi
mkdir -p "$HELIX_CONFIG_PATH"
cp -R "$REPO_ROOT/configs/helix/." "$HELIX_CONFIG_PATH/"

RUNTIME_PATH="$HELIX_CONFIG_PATH/runtime"
if [[ -L "$RUNTIME_PATH" ]]; then
    rm -f "$RUNTIME_PATH"
elif [[ -e "$RUNTIME_PATH" ]]; then
    mv "$RUNTIME_PATH" "$BACKUP_ROOT/runtime"
fi
ln -s "$HELIX_PATH/runtime" "$RUNTIME_PATH"

printf 'Helix %s installed; previous files backed up under %s\n' \
    "$HELIX_VERSION" "$BACKUP_ROOT"

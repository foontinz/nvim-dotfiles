#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLERS="$SCRIPT_DIR/cmd/installers"

echo "==> homebrew"
bash "$INSTALLERS/homebrew.bash"

# Homebrew's installer cannot update this already-running shell. Load it here
# so every subsequent installer can use brew-installed commands.
for BREW in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -x "$BREW" ]]; then
        eval "$("$BREW" shellenv)"
        break
    fi
done
command -v brew >/dev/null 2>&1 || {
    echo "Homebrew is installed but unavailable in PATH" >&2
    exit 1
}

echo "==> git"
bash "$INSTALLERS/git.bash"

echo "==> ssh"
bash "$INSTALLERS/ssh.bash"

echo "==> rust"
bash "$INSTALLERS/rust.bash"

echo "==> zsh + oh-my-zsh"
bash "$INSTALLERS/zsh.bash"

echo "==> tooling (uv, fzf)"
bash "$INSTALLERS/tooling.bash"

echo "==> npm tooling"
bash "$INSTALLERS/npm_tooling.bash"

echo "==> meridian service"
bash "$INSTALLERS/meridian.bash"

echo "==> helix"
bash "$INSTALLERS/helix.bash"

echo "==> tmux"
bash "$INSTALLERS/tmux.bash"

echo "==> ghostty"
bash "$INSTALLERS/ghostty.bash"

echo "==> tb"
bash "$INSTALLERS/tb.bash"

echo "done"

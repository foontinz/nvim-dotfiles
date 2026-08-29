#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLERS="$SCRIPT_DIR/cmd/installers"
FULL_SETUP=0

usage() {
    cat <<'EOF'
Usage: setup.bash [--full]

Runs the general development setup by default.
  --full  Also install personal machine configuration (Git identity, SSH,
          TouchBistro, and Google Workspace MCP)
EOF
}

while (( $# > 0 )); do
    case "$1" in
        --full)
            FULL_SETUP=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

echo "==> directories"
mkdir -p \
    "$HOME/.config" \
    "$HOME/dev" \
    "$HOME/dev/personal" \
    "$HOME/dev/nightly"

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

echo "==> rust"
bash "$INSTALLERS/rust.bash"

echo "==> Go"
bash "$INSTALLERS/go.bash"

echo "==> zsh + oh-my-zsh"
bash "$INSTALLERS/zsh.bash"

echo "==> tooling (uv, fzf)"
bash "$INSTALLERS/tooling.bash"

echo "==> npm tooling"
bash "$INSTALLERS/npm_tooling.bash"

echo "==> helix"
bash "$INSTALLERS/helix.bash"

echo "==> tmux"
bash "$INSTALLERS/tmux.bash"

echo "==> ghostty"
bash "$INSTALLERS/ghostty.bash"

if (( FULL_SETUP )); then
    echo "==> personal git config"
    bash "$INSTALLERS/gitconfig.bash"

    echo "==> personal ssh config"
    bash "$INSTALLERS/ssh.bash"

    echo "==> TouchBistro tooling"
    bash "$INSTALLERS/tb.bash"

    echo "==> Google Workspace MCP"
    bash "$INSTALLERS/google-workspace-mcp.bash"
else
    echo "==> personal machine configuration skipped (use --full to install)"
fi

echo "done"

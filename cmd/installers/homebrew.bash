#!/bin/bash
set -euo pipefail

find_brew() {
    if command -v brew >/dev/null 2>&1; then
        command -v brew
        return
    fi

    local candidate
    for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
        if [[ -x "$candidate" ]]; then
            printf '%s\n' "$candidate"
            return
        fi
    done

    return 1
}

if BREW="$(find_brew)"; then
    echo "Homebrew already installed: $BREW"
    exit 0
fi

if [[ "$(uname -s)" == "Linux" ]]; then
    sudo apt-get update
    sudo apt-get install -y build-essential procps curl file git
fi

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

BREW="$(find_brew)" || {
    echo "Homebrew installation completed but brew could not be located" >&2
    exit 1
}

"$BREW" analytics off
echo "Homebrew installed: $BREW"

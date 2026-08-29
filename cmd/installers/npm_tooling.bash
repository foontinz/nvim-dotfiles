#!/bin/bash
set -euo pipefail

if ! command -v npm >/dev/null 2>&1; then
    brew install node
fi

command -v npm >/dev/null 2>&1 || {
    echo "Node.js installation succeeded but npm is unavailable in PATH" >&2
    exit 1
}

npm upgrade -g && npm update -g
npm install -g pyright
npm install -g prettier

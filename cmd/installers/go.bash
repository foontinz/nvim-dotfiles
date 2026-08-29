#!/bin/bash
set -euo pipefail

brew install go

command -v go >/dev/null 2>&1 || {
    echo "Go installation succeeded but go is unavailable in PATH" >&2
    exit 1
}

go version

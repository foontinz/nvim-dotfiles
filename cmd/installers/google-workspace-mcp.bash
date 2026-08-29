#!/bin/bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SCRIPT_SRC="$REPO_ROOT/cmd/launchd/google-workspace-mcp.bash"
SCRIPT_DST="$HOME/.local/bin/google-workspace-mcp-launchd"
PLIST_SRC="$REPO_ROOT/configs/launchd/com.barbos.google-workspace-mcp.plist"
PLIST_DST="$HOME/Library/LaunchAgents/com.barbos.google-workspace-mcp.plist"
LABEL="com.barbos.google-workspace-mcp"
UID_="$(id -u)"
DOMAIN="gui/$UID_"

mkdir -p "$HOME/.local/bin" "$HOME/Library/LaunchAgents" "$HOME/Library/Logs"

cp "$SCRIPT_SRC" "$SCRIPT_DST"
chmod 755 "$SCRIPT_DST"

python3 - "$PLIST_SRC" "$PLIST_DST" "$SCRIPT_DST" "$HOME" <<'PY'
from pathlib import Path
import sys

source, destination, script, home = map(Path, sys.argv[1:])
plist = source.read_text()
plist = plist.replace('__GOOGLE_WORKSPACE_MCP_SCRIPT__', str(script))
plist = plist.replace('__HOME__', str(home))
destination.write_text(plist)
PY
chmod 644 "$PLIST_DST"

launchctl bootout "$DOMAIN/$LABEL" 2>/dev/null || true
launchctl bootstrap "$DOMAIN" "$PLIST_DST"
launchctl enable "$DOMAIN/$LABEL" 2>/dev/null || true
launchctl kickstart -k "$DOMAIN/$LABEL" 2>/dev/null || true

echo "google workspace mcp launch agent loaded: $LABEL"
echo "logs: ~/Library/Logs/google-workspace-mcp.{out,err}.log"

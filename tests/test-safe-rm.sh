#!/bin/bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GUARD="$ROOT/cmd/safe-rm"
REAL_HOME="$(/usr/bin/dscl . -read "/Users/$(id -un)" NFSHomeDirectory | awk '{print $2}')"
TMP="$(mktemp -d /tmp/safe-rm-test.XXXXXX)"
trap '/bin/rm -rf "$TMP"' EXIT

expect_refused() {
  set +e
  SAFE_RM_DRY_RUN=1 "$GUARD" "$@" >/dev/null 2>&1
  status=$?
  set -e
  [[ "$status" -eq 64 ]] || {
    echo "expected refusal (64), got $status: $*" >&2
    exit 1
  }
}

expect_refused -rf "$REAL_HOME"
expect_refused -rf "$REAL_HOME/."
expect_refused -rf "$REAL_HOME/.."
expect_refused -rf /
expect_refused -rf "$REAL_HOME/dev" "$REAL_HOME/Library"

# A poisoned HOME environment must not disable protection of the account home.
set +e
HOME=/tmp/not-the-account-home SAFE_RM_DRY_RUN=1 "$GUARD" -rf "$REAL_HOME" >/dev/null 2>&1
status=$?
set -e
[[ "$status" -eq 64 ]]

# Ordinary scoped removal must still work.
mkdir -p "$TMP/tree/child"
touch "$TMP/tree/child/file"
"$GUARD" -rf "$TMP/tree"
[[ ! -e "$TMP/tree" ]]

touch "$TMP/file"
"$GUARD" -f "$TMP/file"
[[ ! -e "$TMP/file" ]]

echo "safe-rm tests: PASS"

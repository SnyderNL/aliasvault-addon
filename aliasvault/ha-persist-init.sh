#!/usr/bin/env bash
set -euo pipefail

echo "[ha-persist] init: restoring persistent data into runtime paths..."

restore_dir() {
  local persist="$1"
  local runtime="$2"
  mkdir -p "$persist" "$runtime"
  if [ -n "$(ls -A "$persist" 2>/dev/null || true)" ]; then
    cp -a "$persist"/. "$runtime"/
  fi
}

restore_dir /data/database /database
restore_dir /data/logs /logs
restore_dir /data/secrets /secrets
restore_dir /data/certificates /certificates

echo "[ha-persist] init: restore complete"

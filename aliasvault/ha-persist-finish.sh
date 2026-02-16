#!/usr/bin/env bash
set -euo pipefail

echo "[ha-persist] finish: syncing runtime data back to /data..."

backup_dir() {
  local runtime="$1"
  local persist="$2"

  mkdir -p "$persist"

  # Wipe destination including hidden files/directories.
  find "$persist" -mindepth 1 -delete

  if [ -d "$runtime" ] && [ -n "$(ls -A "$runtime" 2>/dev/null || true)" ]; then
    cp -a "$runtime"/. "$persist"/
  fi
}

backup_dir /database /data/database
backup_dir /logs /data/logs
backup_dir /secrets /data/secrets
backup_dir /certificates /data/certificates

echo "[ha-persist] finish: sync complete"

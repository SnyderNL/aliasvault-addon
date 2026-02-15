#!/usr/bin/env bash
set -euo pipefail

echo "[AliasVault addon] Preparing persistent storage links..."

mkdir -p /data/database /data/logs /data/secrets

link_path() {
  local target="$1"
  local link="$2"

  if [ -L "$link" ]; then
    return 0
  fi

  if [ -e "$link" ]; then
    rm -rf "$link"
  fi

  ln -s "$target" "$link"
}

link_path /data/database /database
link_path /data/logs /logs
link_path /data/secrets /secrets

echo "[AliasVault addon] Starting upstream AliasVault init..."
exec /init

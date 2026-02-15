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

OPTIONS_FILE="/data/options.json"
SSL_ENABLED="false"
CERTFILE="fullchain.pem"
KEYFILE="privkey.pem"

if [ -f "$OPTIONS_FILE" ]; then
  compact="$(tr -d '\n\r ' < "$OPTIONS_FILE")"
  parsed_ssl="$(printf '%s' "$compact" | sed -n 's/.*"ssl":\(true\|false\).*/\1/p')"
  parsed_cert="$(printf '%s' "$compact" | sed -n 's/.*"certfile":"\([^"]*\)".*/\1/p')"
  parsed_key="$(printf '%s' "$compact" | sed -n 's/.*"keyfile":"\([^"]*\)".*/\1/p')"

  [ -n "$parsed_ssl" ] && SSL_ENABLED="$parsed_ssl"
  [ -n "$parsed_cert" ] && CERTFILE="$parsed_cert"
  [ -n "$parsed_key" ] && KEYFILE="$parsed_key"
fi

if [ "$SSL_ENABLED" = "true" ]; then
  SRC_CERT="/ssl/$CERTFILE"
  SRC_KEY="/ssl/$KEYFILE"
  DST_DIR="/certificates/ssl"

  if [ -f "$SRC_CERT" ] && [ -f "$SRC_KEY" ]; then
    mkdir -p "$DST_DIR"
    cp -f "$SRC_CERT" "$DST_DIR/cert.pem"
    cp -f "$SRC_KEY" "$DST_DIR/key.pem"
    chmod 644 "$DST_DIR/cert.pem"
    chmod 600 "$DST_DIR/key.pem"
    echo "[ha-persist] init: custom SSL cert loaded from /ssl ($CERTFILE, $KEYFILE)"
  else
    echo "[ha-persist] init: SSL enabled but cert/key not found in /ssl, falling back to AliasVault certificate handling"
  fi
fi

echo "[ha-persist] init: restore complete"

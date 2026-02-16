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

if [ -f "$OPTIONS_FILE" ] && command -v python3 >/dev/null 2>&1; then
  readarray -t parsed < <(
    python3 - "$OPTIONS_FILE" <<'PY'
import json
import sys

path = sys.argv[1]
try:
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
except Exception:
    data = {}

ssl = data.get("ssl", False)
cert = data.get("certfile", "fullchain.pem")
key = data.get("keyfile", "privkey.pem")

print("true" if bool(ssl) else "false")
print(str(cert) if cert is not None else "fullchain.pem")
print(str(key) if key is not None else "privkey.pem")
PY
  )

  if [ "${#parsed[@]}" -ge 3 ]; then
    SSL_ENABLED="${parsed[0]}"
    CERTFILE="${parsed[1]}"
    KEYFILE="${parsed[2]}"
  fi
else
  echo "[ha-persist] init: python3 not available, using default SSL options"
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

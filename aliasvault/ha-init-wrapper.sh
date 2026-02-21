#!/command/with-contenv bash
set -euo pipefail

echo "[ha-persist] init: preparing persistent links under /data..."

migrate_and_link() {
  local target="$1"
  local link="$2"

  mkdir -p "$target"

  if [ -L "$link" ]; then
    return 0
  fi

  # Some upstream paths can be mounted/busy and cannot be replaced with a symlink.
  # In that case, keep runtime path as-is and just seed data one-way from /data when useful.
  if [ -d "$link" ] && command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$link"; then
    echo "[ha-persist] init: $link is a mountpoint; skipping symlink replacement"
    if [ -z "$(ls -A "$link" 2>/dev/null || true)" ] && [ -n "$(ls -A "$target" 2>/dev/null || true)" ]; then
      cp -a "$target"/. "$link"/
    fi
    return 0
  fi

  if [ -d "$link" ]; then
    if [ -z "$(ls -A "$target" 2>/dev/null || true)" ] && [ -n "$(ls -A "$link" 2>/dev/null || true)" ]; then
      cp -a "$link"/. "$target"/
    fi
    rm -rf "$link" || true
  elif [ -e "$link" ]; then
    rm -rf "$link" || true
  fi

  ln -s "$target" "$link"
}

migrate_and_link /data/database /database
migrate_and_link /data/logs /logs
migrate_and_link /data/secrets /secrets
migrate_and_link /data/certificates /certificates

OPTIONS_FILE="/data/options.json"
SSL_ENABLED="false"
CERTFILE="fullchain.pem"
KEYFILE="privkey.pem"

if [ -f "$OPTIONS_FILE" ]; then
  if command -v python3 >/dev/null 2>&1; then
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
    # Fallback parser when python3 is unavailable in runtime image
    ssl_val=$(grep -Eo '"ssl"[[:space:]]*:[[:space:]]*(true|false)' "$OPTIONS_FILE" | tail -n1 | grep -Eo '(true|false)' || true)
    cert_val=$(grep -Eo '"certfile"[[:space:]]*:[[:space:]]*"[^"]+"' "$OPTIONS_FILE" | tail -n1 | sed -E 's/.*"([^"]+)"$/\1/' || true)
    key_val=$(grep -Eo '"keyfile"[[:space:]]*:[[:space:]]*"[^"]+"' "$OPTIONS_FILE" | tail -n1 | sed -E 's/.*"([^"]+)"$/\1/' || true)

    if [ -n "$ssl_val" ]; then SSL_ENABLED="$ssl_val"; fi
    if [ -n "$cert_val" ]; then CERTFILE="$cert_val"; fi
    if [ -n "$key_val" ]; then KEYFILE="$key_val"; fi

    echo "[ha-persist] init: python3 missing, used fallback options parser"
  fi
else
  echo "[ha-persist] init: options file not found at $OPTIONS_FILE"
fi

echo "[ha-persist] init: ssl=$SSL_ENABLED certfile=$CERTFILE keyfile=$KEYFILE"

if [ "$SSL_ENABLED" = "true" ]; then
  SRC_CERT="/ssl/$CERTFILE"
  SRC_KEY="/ssl/$KEYFILE"
  DST_DIR="/certificates/ssl"

  if [ -f "$SRC_CERT" ] && [ -f "$SRC_KEY" ]; then
    mkdir -p "$DST_DIR"
    cp -f "$SRC_CERT" "$DST_DIR/cert.pem"
    cp -f "$SRC_KEY" "$DST_DIR/key.pem"

    # Prevent upstream init from replacing custom certs with self-signed ones.
    echo "${HOSTNAME:-localhost}" > "$DST_DIR/.hostname_marker"

    chmod 644 "$DST_DIR/cert.pem"
    chmod 600 "$DST_DIR/key.pem"
    chmod 644 "$DST_DIR/.hostname_marker"
    echo "[ha-persist] init: custom SSL cert loaded from /ssl ($CERTFILE, $KEYFILE)"
  else
    echo "[ha-persist] init: SSL enabled but cert/key not found in /ssl; upstream self-signed handling remains active"
  fi
fi

echo "[ha-persist] init: handoff to upstream init"
exec /etc/s6-overlay/s6-rc.d/init/script.upstream

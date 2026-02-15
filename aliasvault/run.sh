#!/command/with-contenv bash
set -e

echo "[AliasVault] Starting..."

# Force data directories
mkdir -p /data/postgres
mkdir -p /data/aliasvault
mkdir -p /data/certs

# Redirect postgres data
export PGDATA=/data/postgres

# Redirect AliasVault data
export DATA_DIR=/data/aliasvault

# Redirect certs
export SSL_DIR=/data/certs

# Start original entrypoint
exec /entrypoint.sh
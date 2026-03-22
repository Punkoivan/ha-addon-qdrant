#!/bin/bash
set -e

OPTIONS="/data/options.json"

# Parse a string value from flat JSON options file
# Usage: get_option "key" "default"
get_option() {
    local val
    val=$(grep -o "\"${1}\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$OPTIONS" | cut -d'"' -f4)
    echo "${val:-${2}}"
}

# Parse a boolean value (unquoted true/false in JSON)
# Usage: get_bool "key" "default"
get_bool() {
    local val
    val=$(grep -o "\"${1}\"[[:space:]]*:[[:space:]]*[a-z]*" "$OPTIONS" | grep -o '[a-z]*$')
    echo "${val:-${2}}"
}

# Hand over /data to nobody — qdrant will create subdirectories itself
chown nobody:nogroup /data

# Read options before privilege drop
LOG_LEVEL=$(get_option "log_level" "info" | tr '[:lower:]' '[:upper:]')
API_KEY=$(get_option "api_key" "")
READ_ONLY_API_KEY=$(get_option "read_only_api_key" "")
TLS=$(get_bool "tls" "false")
CERTFILE=$(get_option "certfile" "")
KEYFILE=$(get_option "keyfile" "")

export QDRANT__STORAGE__STORAGE_PATH="/data/storage"
export QDRANT__LOG_LEVEL="$LOG_LEVEL"
export QDRANT__SERVICE__HTTP_PORT=6333
export QDRANT__SERVICE__GRPC_PORT=6334

if [ -n "$API_KEY" ]; then
    export QDRANT__SERVICE__API_KEY="$API_KEY"
fi

if [ -n "$READ_ONLY_API_KEY" ]; then
    export QDRANT__SERVICE__READ_ONLY_API_KEY="$READ_ONLY_API_KEY"
fi

if [ "$TLS" = "true" ] && [ -n "$CERTFILE" ]; then
    # Derive key filename from cert if not specified (replace extension with .key)
    if [ -z "$KEYFILE" ]; then
        KEYFILE="${CERTFILE%.*}.key"
    fi
    # Copy to /data so nobody can read them
    cp "/ssl/${CERTFILE}" /data/tls.crt
    cp "/ssl/${KEYFILE}" /data/tls.key
    chown nobody:nogroup /data/tls.crt /data/tls.key
    chmod 400 /data/tls.crt /data/tls.key
    export QDRANT__SERVICE__ENABLE_TLS=true
    export QDRANT__TLS__CERT="/data/tls.crt"
    export QDRANT__TLS__KEY="/data/tls.key"
fi

# Drop privileges and exec qdrant (workdir /data so relative paths resolve correctly)
cd /data && exec gosu nobody /qdrant/qdrant

#!/bin/bash
set -e

OPTIONS="/data/options.json"
STORAGE="/data/storage"

# Prepare storage directory with correct ownership (still root here)
mkdir -p "$STORAGE"
chown qdrant:qdrant "$STORAGE"

# Read options before privilege drop
LOG_LEVEL=$(jq -r '.log_level // "info"' "$OPTIONS" | tr '[:lower:]' '[:upper:]')
API_KEY=$(jq -r '.api_key // ""' "$OPTIONS")
READ_ONLY_API_KEY=$(jq -r '.read_only_api_key // ""' "$OPTIONS")

export QDRANT__STORAGE__STORAGE_PATH="$STORAGE"
export QDRANT__LOG_LEVEL="$LOG_LEVEL"
export QDRANT__SERVICE__HTTP_PORT=6333
export QDRANT__SERVICE__GRPC_PORT=6334

if [ -n "$API_KEY" ]; then
    export QDRANT__SERVICE__API_KEY="$API_KEY"
fi

if [ -n "$READ_ONLY_API_KEY" ]; then
    export QDRANT__SERVICE__READ_ONLY_API_KEY="$READ_ONLY_API_KEY"
fi

# Drop privileges and exec qdrant
exec gosu qdrant /qdrant/qdrant

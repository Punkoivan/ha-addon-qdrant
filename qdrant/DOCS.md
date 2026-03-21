# Qdrant Add-on Documentation

## Storage

All data is stored in the add-on's private `/data/storage` directory.
This directory is included in Home Assistant snapshots/backups automatically.

## Configuration

### `log_level`
Controls Qdrant log verbosity. Options: `debug`, `info`, `warn`, `error`.
Default: `info`.

### `api_key`
Static API key for full (read + write) access.
All requests must include the header `api-key: <your_key>`.

Leave empty to run without authentication (suitable for trusted local networks only).

### `read_only_api_key`
Static API key for read-only access (queries only, no writes or collection management).
Useful for clients that only need to search — e.g. a Streamlit UI on a remote device.

Leave empty to disable read-only key.

## Ports

| Port | Protocol | Description         |
|------|----------|---------------------|
| 6333 | TCP      | Qdrant REST API     |
| 6334 | TCP      | Qdrant gRPC API     |

## Security Notes

- The Qdrant process runs as a non-root user (`qdrant`) inside the container.
- If your Home Assistant is accessible from the internet, always set an `api_key`.
- The add-on does **not** mount `/share` or any other shared directory.

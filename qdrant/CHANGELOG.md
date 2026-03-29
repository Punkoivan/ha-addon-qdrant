# Changelog

## 1.1.3

- Added `certcontent` and `keycontent` options — paste base64-encoded PEM directly in the UI as an alternative to `certfile`/`keyfile`

## 1.1.2
- Fixed TLS option mounts.

## 1.1.1
- Intermediate version, actually skipped

## 1.1.0

- Added optional TLS support via `/ssl/` certificates
- New options: `certfile`, `keyfile`, `tls`

## 1.0.2

- Fixed `{arch}` placeholder in image name for HA Supervisor

## 1.0.1

- Fixed: run as `nobody` user for better security
- Fixed: options parsing via grep/cut (no jq dependency)

## 1.0.0

- Initial release: Qdrant v1.17.0
- Options: `log_level`, `api_key`, `read_only_api_key`
- Ports: 6333 (REST API), 6334 (gRPC)

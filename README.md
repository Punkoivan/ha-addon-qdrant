# Home Assistant Add-on: Qdrant

[![GitHub Release](https://img.shields.io/github/release/punkoivan/ha-addon-qdrant.svg)](https://github.com/punkoivan/ha-addon-qdrant/releases)
[![License](https://img.shields.io/github/license/punkoivan/ha-addon-qdrant.svg)](LICENSE)

[Qdrant](https://qdrant.tech) vector database as a Home Assistant add-on.
Run a local vector search engine for AI and RAG (Retrieval-Augmented Generation) applications — no cloud required.

## Installation

1. Open **Settings → Add-ons → Add-on Store** in Home Assistant.
2. Click the three-dot menu (⋮) in the top-right corner and select **Repositories**.
3. Add the following URL:
   ```
   https://github.com/punkoivan/ha-addon-qdrant
   ```
4. Find **Qdrant** in the add-on store and click **Install**.

## Configuration

```yaml
log_level: info       # debug | info | warn | error
api_key: ""           # full access key (empty = no auth)
read_only_api_key: "" # read-only key (empty = disabled)
```

### Authentication

- **`api_key`** — required for write access (ingestion, collection management).
- **`read_only_api_key`** — for clients that only query (e.g. a Streamlit UI on a Raspberry Pi).
- Both empty — open access, suitable only for isolated local networks.

## Ports

| Port | Description          |
|------|----------------------|
| 6333 | REST API             |
| 6334 | gRPC API             |

## Storage

Data is stored in the add-on's private storage and is included in Home Assistant backups automatically.

## Supported Architectures

- `amd64`
- `aarch64` (Raspberry Pi 4+)

## Qdrant Version

This add-on is based on **Qdrant v1.17.0**.

## License

MIT — see [LICENSE](LICENSE).

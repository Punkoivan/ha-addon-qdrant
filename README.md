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
log_level: <string>           # debug | info | warn | error (default = info).
api_key: <string>             # full access key (empty = no auth).
read_only_api_key: <string>   # read-only key (empty = disabled).
tls: <bool>                   # true or false, enable or disable TLS. False by default.
certfile: <string>            # path to the certificate. Read TLS section.
keyfile: <string>             # path to the key. Read TLS section.
certcontent: <base64 string>  # encoded certificate. Read TLS section.
keycontent: <base64 string>   # encoded key. Read TLS section.

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
That was a conscious decision not to mount the entire /share/ directory inside add-on.

## TLS

Since Data stored inside supervisor's storage, passing certfile and keyfile requires some trick.
First you would store both cert and file on the backend.
After that use ssh or any other addon with root backend access and move certificate and key into supervisor add-on "data/ssl/" file.
Restart add-on.

As an alternative solution you can provide both certcontent and keycontent into appropraite fields.
To achieve that use your certfile and keyfile and than convert with `base64 -e -w0`. Yup, I know that usually cert and key are already base64 encoded strings.

Additionally, you can use TLS cert and key that already used for your HA instance if you have the same domain and/or wildcarded certificate.

## Supported Architectures

- `amd64`
- `aarch64` (Raspberry Pi 4+)


## Qdrant Version

This add-on is based on **Qdrant v1.17.0**.

## License

MIT — see [LICENSE](LICENSE).

## AI usage
Yup, add-on developed with huge AI (claude code) assistance but with security by design. Should you have any question and/or pull request - you are welcome! :)

# Global ARG — must be before any FROM to be usable in FROM instructions
ARG BUILD_FROM=qdrant/qdrant:v1.17.0

# Stage 1: fetch static gosu binary
FROM debian:12-slim AS tools
ARG TARGETARCH
RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates \
    && wget -q -O /tmp/gosu "https://github.com/tianon/gosu/releases/download/1.17/gosu-${TARGETARCH}" \
    && chmod +x /tmp/gosu \
    && rm -rf /var/lib/apt/lists/*

# Stage 2: addon image based on official qdrant
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version="${BUILD_VERSION}" \
    maintainer="punkoivan" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${BUILD_REF}" \
    org.opencontainers.image.version="${BUILD_VERSION}"

USER root

COPY --from=tools /tmp/gosu /usr/local/bin/gosu
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

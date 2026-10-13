FROM debian:trixie-slim

ARG TARGETARCH

RUN apt-get update && apt-get install -y \
    curl \
    libgomp1

RUN set -eux; \
    case "$TARGETARCH" in \
        "amd64")  OS_ARCH="amd64" ;; \
        "arm64")  OS_ARCH="aarch64" ;; \
        *) echo "Unsupported arch: $TARGETARCH" && exit 1 ;; \
    esac; \
    curl -fsSLo /tmp/sphinx.tar.gz \
        "https://sphinxsearch.com/files/sphinx-3.9.1-141d2ea-linux-${OS_ARCH}.tar.gz"; \
    tar -xzf /tmp/sphinx.tar.gz -C /tmp; \
    rm /tmp/sphinx.tar.gz;

RUN chmod +x /tmp/sphinx-3.9.1/bin/* \
    && mv /tmp/sphinx-3.9.1/bin/* /usr/local/bin/ \
    && rm -rf /tmp/sphinx-3.9.1

RUN mkdir -p /opt/sphinx/index

CMD [ "searchd" ]

#!/bin/sh
set -e

CERT_DIR="/opt/certs"

if [ "$APP_ENV" = "dev" ] && [ -d "$CERT_DIR" ]; then
    OPENSSL_CNF_FILE="/tmp/openssl.cnf"
    KEY_FILE="$CERT_DIR/server.key"
    CERT_FILE="$CERT_DIR/server.crt"

    if [ ! -f "$KEY_FILE" ]; then
        openssl genrsa -out "$KEY_FILE" 2048
    fi

    if [ ! -f "$CERT_FILE" ]; then
        cat > "$OPENSSL_CNF_FILE" <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
CN = localhost

[v3_req]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = ${APP_DEV_DOMAIN}
IP.1 = 127.0.0.1
EOF

        openssl req \
            -x509 \
            -nodes \
            -days 3650 \
            -newkey rsa:2048 \
            -keyout "$KEY_FILE" \
            -out "$CERT_FILE" \
            -config "$OPENSSL_CNF_FILE"

        rm -rf "$OPENSSL_CNF_FILE"
    fi

    cp "$CERT_FILE" /usr/local/share/ca-certificates/server.crt

    update-ca-certificates
fi

exec "$@"

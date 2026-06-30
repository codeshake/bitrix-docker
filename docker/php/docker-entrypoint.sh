#!/bin/sh
set -e

cp /opt/certs/server.crt /certs/server.crt
cp /opt/certs/server.key /certs/server.key

exec "$@"

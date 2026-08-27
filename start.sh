#!/bin/sh

set -e

mkdir -p \
    /run/nginx \
    /tmp/client_temp \
    /tmp/proxy_temp

echo "Starting 3x-ui..."

/app/x-ui &

echo "Starting nginx on port 8080..."

exec nginx -g 'daemon off;'

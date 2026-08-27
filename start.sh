#!/bin/sh

set -eu

mkdir -p \
    /run/nginx \
    /tmp/client_temp \
    /tmp/proxy_temp \
    /tmp/fastcgi_temp \
    /tmp/uwsgi_temp \
    /tmp/scgi_temp

echo "starting 3x-ui"

/app/x-ui &
XUI_PID=$!

echo "starting nginx"

nginx -g 'daemon off;' &
NGINX_PID=$!

shutdown() {
    echo "stopping services"

    kill "$NGINX_PID" 2>/dev/null || true
    kill "$XUI_PID" 2>/dev/null || true

    wait "$NGINX_PID" 2>/dev/null || true
    wait "$XUI_PID" 2>/dev/null || true

    exit 0
}

trap shutdown INT TERM

while true; do
    if ! kill -0 "$XUI_PID" 2>/dev/null; then
        echo "3x-ui stopped"
        shutdown
    fi

    if ! kill -0 "$NGINX_PID" 2>/dev/null; then
        echo "nginx stopped"
        shutdown
    fi

    sleep 5
done

FROM ghcr.io/mhsanaei/3x-ui:latest

RUN apk add --no-cache nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh \
    && mkdir -p /run/nginx \
    && mkdir -p /tmp/client_temp \
    && mkdir -p /tmp/proxy_temp \
    && mkdir -p /tmp/fastcgi_temp \
    && mkdir -p /tmp/uwsgi_temp \
    && mkdir -p /tmp/scgi_temp

ENV XUI_ENABLE_FAIL2BAN=false \
    XUI_PORT=2053 \
    XUI_INIT_WEB_BASE_PATH=/panel \
    XUI_SKIP_HSTS=true \
    XRAY_VMESS_AEAD_FORCED=false

EXPOSE 8080

ENTRYPOINT ["/start.sh"]

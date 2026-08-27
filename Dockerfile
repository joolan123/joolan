FROM ghcr.io/mhsanaei/3x-ui:latest

RUN apk add --no-cache nginx \
    && mkdir -p /run/nginx \
    /tmp/client_temp \
    /tmp/proxy_temp

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh

RUN chmod +x /start.sh

ENV XUI_ENABLE_FAIL2BAN=false
ENV XUI_SKIP_HSTS=true
ENV XRAY_VMESS_AEAD_FORCED=false

EXPOSE 8080

ENTRYPOINT ["/start.sh"]

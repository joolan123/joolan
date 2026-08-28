FROM ghcr.io/xtls/xray-core:26.7.11

COPY config.json /usr/local/etc/xray/config.json

ENTRYPOINT ["/usr/local/bin/xray"]
CMD ["run", "-config", "/usr/local/etc/xray/config.json"]

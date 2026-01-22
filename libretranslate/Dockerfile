ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:latest
FROM libretranslate/libretranslate:latest

# Environment used by our launcher
ENV LT_HOST=0.0.0.0 \
    LT_PORT=5000 \
    HOME=/root

# Copy launcher
COPY rootfs /

# Ensure our launcher is executable
RUN chmod +x /usr/bin/run.sh

# Expose API
EXPOSE 5000

# Start LibreTranslate via our launcher, which reads /data/options.json
CMD ["/usr/bin/run.sh"]

ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.6
FROM $BUILD_FROM

WORKDIR /app

RUN apk add --no-cache python3 py3-pip \
    && pip install --no-cache-dir libretranslate argostranslate

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]

ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:15.0.6
FROM $BUILD_FROM

WORKDIR /app

RUN apk add --no-cache python3 py3-pip

# Virtuelle Umgebung erstellen und aktivieren
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --no-cache-dir libretranslate argostranslate

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]

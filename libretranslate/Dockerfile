ARG BUILD_FROM=python:3.12-slim
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Installiere Abhängigkeiten
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        curl \
        jq \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Installiere bashio (Add-on Hilfsbibliothek)
RUN mkdir -p /usr/lib/bashio && \
    curl -sSL https://raw.githubusercontent.com/hassio-addons/bashio/main/lib/bashio.sh -o /usr/lib/bashio/bashio.sh

# Setze bashio in PATH
ENV BASHIO_LIB="/usr/lib/bashio"

# Installiere LibreTranslate + ArgosTranslate
RUN pip install --no-cache-dir libretranslate argostranslate

# Add-on Startskript
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

# Home Assistant Add-on startet über /run.sh
CMD ["/run.sh"]

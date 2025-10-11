ARG BUILD_FROM=ghcr.io/hassio-addons/base:15.0.6
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Minimal: python + pip (base image hat apk)
RUN apk add --no-cache python3 py3-pip

# Installiere LibreTranslate (und Argos falls benötigt)
RUN pip install --no-cache-dir libretranslate argostranslate

# Kopiere Startskript
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000

CMD ["/run.sh"]

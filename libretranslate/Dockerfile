ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:latest
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Systemabhängigkeiten installieren
RUN apk update && apk upgrade
RUN apk add python3 py3-pip icu-dev qt5-qtbase-dev


# Virtuelle Umgebung
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Pip aktualisieren
RUN pip install --upgrade pip

RUN pip install libretranslate

# Copy root filesystem
COPY rootfs /

ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:latest
FROM $BUILD_FROM

# Arbeitsverzeichnis
WORKDIR /app

# Systemabhängigkeiten installieren
RUN apk update && apk upgrade
RUN apk add python3 py3-pip icu-dev qt5-qtbase-dev g++ make

RUN pip install libretranslate

# Copy root filesystem
COPY rootfs /

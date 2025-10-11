ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

WORKDIR /app

# Systemabhängigkeiten für pip + LibreTranslate
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    g++ \
    make \
    bash \
    git \
    build-base \
    libffi-dev \
    musl-dev \
    cargo \
    cmake

# Virtuelle Umgebung
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Pip updaten
RUN pip install --upgrade pip setuptools wheel

# LibreTranslate + ArgosTranslate installieren (inklusive PyQt5 via pip)
RUN pip install --no-cache-dir libretranslate argostranslate PyQt5-sip PyQt5

# Startskript
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]

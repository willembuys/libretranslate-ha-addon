ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM $BUILD_FROM

WORKDIR /app

# Systemabhängigkeiten
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
    cmake \
    cargo

# Virtuelle Umgebung
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Pip upgraden
RUN pip install --upgrade pip setuptools wheel

# LibreTranslate + ArgosTranslate (ohne PyQt5)
RUN pip install --no-cache-dir libretranslate argostranslate

# Startskript
COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5000
CMD ["/run.sh"]

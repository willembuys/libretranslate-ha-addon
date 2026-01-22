ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:latest
FROM libretranslate/libretranslate:latest

ENV DEBIAN_FRONTEND=noninteractive \
    LT_HOST=0.0.0.0 \
    LT_PORT=5000 \
    PYTHONUNBUFFERED=1 \
    HOME=/root \
    LT_VENV=/opt/lt

# Set working directory
WORKDIR /app

# Install system dependencies required by LibreTranslate / Argos Translate
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-dev \
        python3-venv \
        build-essential \
        libicu-dev \
        curl && \
      rm -rf /var/lib/apt/lists/*

# Install LibreTranslate
RUN pip3 install --no-cache-dir --break-system-packages libretranslate

# Copy root filesystem
COPY rootfs /
